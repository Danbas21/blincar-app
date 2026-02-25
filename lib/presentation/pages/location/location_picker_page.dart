// lib/presentation/pages/location/location_picker_page.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:blincar_app/l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:http/http.dart' as http;
import '../../../core/theme/app_theme.dart';
import '../../../core/config/env_config.dart';

/// Modelo para representar una ubicación seleccionada
class SelectedLocation {
  final String address;
  final double latitude;
  final double longitude;

  const SelectedLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() => address;
}

/// Bounds de México para restringir búsquedas y selecciones
class _MexicoBounds {
  static const double minLat = 14.50;
  static const double maxLat = 32.72;
  static const double minLng = -118.40;
  static const double maxLng = -86.72;

  static bool contains(LatLng point) {
    return point.latitude >= minLat &&
        point.latitude <= maxLat &&
        point.longitude >= minLng &&
        point.longitude <= maxLng;
  }
}

/// Página para seleccionar ubicación estilo Uber con Places Autocomplete
class LocationPickerPage extends StatefulWidget {
  final String title;
  final LatLng? initialLocation;
  final bool isOrigin; // true = origen (verde), false = destino (rojo)

  const LocationPickerPage({
    super.key,
    this.title = 'Seleccionar ubicación',
    this.initialLocation,
    this.isOrigin = true,
  });

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  // Estado
  LatLng? _selectedLocation;
  String _selectedAddress = '';
  bool _isLoading = false;
  bool _isSearching = false;
  List<_PlaceResult> _searchResults = [];

  // Ubicación por defecto (CDMX)
  static const LatLng _defaultLocation = LatLng(19.4326, -99.1332);

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.initialLocation ?? _defaultLocation;
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  /// Obtiene la ubicación actual del usuario
  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        setState(() => _isLoading = false);
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final newLocation = LatLng(position.latitude, position.longitude);

      // Verificar que la ubicación esté en México
      if (!_MexicoBounds.contains(newLocation)) {
        setState(() => _isLoading = false);
        return;
      }

      setState(() {
        _selectedLocation = newLocation;
        _isLoading = false;
      });

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(newLocation, 16),
      );

      await _getAddressFromLatLng(newLocation);
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  /// Convierte coordenadas a dirección usando Geocoding API via backend
  Future<void> _getAddressFromLatLng(LatLng location) async {
    try {
      final baseUrl = EnvConfig.apiBaseUrl;
      final url = Uri.parse(
        '$baseUrl/api/routes/places/geocode'
        '?lat=${location.latitude}&lng=${location.longitude}',
      );

      final response = await http.get(url).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        if (data['success'] == true && data['data'] != null) {
          final address = data['data']['formattedAddress'] as String? ?? '';
          if (address.isNotEmpty) {
            setState(() => _selectedAddress = address);
            return;
          }
        }
      }
    } catch (_) {}

    // Fallback: usar geocoding nativo del dispositivo (funciona con la key SHA-1 de Android)
    try {
      final placemarks = await geo.placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = <String>[
          if (p.street != null && p.street!.isNotEmpty) p.street!,
          if (p.subLocality != null && p.subLocality!.isNotEmpty) p.subLocality!,
          if (p.locality != null && p.locality!.isNotEmpty) p.locality!,
          if (p.administrativeArea != null && p.administrativeArea!.isNotEmpty)
            p.administrativeArea!,
        ];
        final address = parts.join(', ');
        if (address.isNotEmpty) {
          setState(() => _selectedAddress = address);
          return;
        }
      }
    } catch (_) {}

    setState(() {
      _selectedAddress =
          '${location.latitude.toStringAsFixed(5)}, ${location.longitude.toStringAsFixed(5)}';
    });
  }

  /// Búsqueda de lugares estilo Uber - usa backend como proxy (misma key que Directions)
  Future<void> _searchPlaces(String query) async {
    if (query.length < 2) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() => _isSearching = true);

    try {
      final baseUrl = EnvConfig.apiBaseUrl;
      final url = Uri.parse(
        '$baseUrl/api/routes/places/autocomplete'
        '?input=${Uri.encodeComponent(query)}',
      );

      final response = await http.get(url).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        if (data['success'] == true && data['data'] != null) {
          final predictions =
              data['data']['predictions'] as List<dynamic>? ?? [];

          final results = predictions.map((p) {
            return _PlaceResult(
              placeId: p['placeId'] as String? ?? '',
              mainText: p['mainText'] as String? ?? '',
              secondaryText: p['secondaryText'] as String? ?? '',
              fullDescription: p['fullDescription'] as String? ?? '',
            );
          }).toList();

          setState(() {
            _searchResults = results;
            _isSearching = false;
          });
          return;
        }
      }
    } catch (_) {}

    // Fallback: usar geocoding nativo del dispositivo para búsqueda básica
    try {
      final locations = await geo.locationFromAddress('$query, México');
      if (locations.isNotEmpty) {
        final results = <_PlaceResult>[];
        for (final loc in locations.take(4)) {
          try {
            final marks = await geo.placemarkFromCoordinates(loc.latitude, loc.longitude);
            if (marks.isNotEmpty) {
              final p = marks.first;
              final main = (p.street?.isNotEmpty == true ? p.street! : null) ??
                  (p.thoroughfare?.isNotEmpty == true ? p.thoroughfare! : null) ??
                  query;
              final secondaryParts = <String>[
                if (p.subLocality?.isNotEmpty == true) p.subLocality!,
                if (p.locality?.isNotEmpty == true) p.locality!,
                if (p.administrativeArea?.isNotEmpty == true) p.administrativeArea!,
              ];
              final secondary = secondaryParts.join(', ');
              final full = [main, if (secondary.isNotEmpty) secondary].join(', ');
              results.add(_PlaceResult(
                placeId: '',
                mainText: main,
                secondaryText: secondary,
                fullDescription: full,
                fallbackLat: loc.latitude,
                fallbackLng: loc.longitude,
              ));
            }
          } catch (_) {}
        }
        if (results.isNotEmpty) {
          setState(() {
            _searchResults = results;
            _isSearching = false;
          });
          return;
        }
      }
    } catch (_) {}

    setState(() {
      _searchResults = [];
      _isSearching = false;
    });
  }

  /// Obtiene coordenadas de un Place ID (Google Places Details)
  Future<void> _selectPlace(_PlaceResult place) async {
    _searchFocus.unfocus();
    setState(() {
      _searchResults = [];
      _searchController.text = place.fullDescription;
    });

    // Resultado del fallback geocoding nativo (sin placeId pero con lat/lng)
    if (place.placeId.isEmpty && place.fallbackLat != null && place.fallbackLng != null) {
      final latLng = LatLng(place.fallbackLat!, place.fallbackLng!);
      if (!_MexicoBounds.contains(latLng)) {
        _showOutsideMexicoError();
        return;
      }
      setState(() {
        _selectedLocation = latLng;
        _selectedAddress = place.fullDescription;
        _searchController.text = place.fullDescription;
      });
      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16));
      return;
    }

    // Obtener coordenadas del Place ID via backend
    if (place.placeId.isNotEmpty) {
      setState(() => _isLoading = true);

      try {
        final baseUrl = EnvConfig.apiBaseUrl;
        final url = Uri.parse(
          '$baseUrl/api/routes/places/details'
          '?placeId=${Uri.encodeComponent(place.placeId)}',
        );

        final response =
            await http.get(url).timeout(const Duration(seconds: 8));

        if (response.statusCode == 200) {
          final data = json.decode(response.body) as Map<String, dynamic>;
          if (data['success'] == true && data['data'] != null) {
            final details = data['data'] as Map<String, dynamic>;
            final lat = (details['lat'] as num?)?.toDouble();
            final lng = (details['lng'] as num?)?.toDouble();
            final name = details['name'] as String? ?? '';
            final formattedAddress =
                details['formattedAddress'] as String? ?? place.fullDescription;
            // Mostrar nombre del lugar si existe (ej: "Plaza Forum Buenavista"),
            // si no, mostrar la dirección exacta
            final displayAddress = name.isNotEmpty ? name : formattedAddress;

            if (lat != null && lng != null) {
              final latLng = LatLng(lat, lng);

              if (!_MexicoBounds.contains(latLng)) {
                setState(() => _isLoading = false);
                _showOutsideMexicoError();
                return;
              }

              setState(() {
                _selectedLocation = latLng;
                _selectedAddress = displayAddress;
                _searchController.text = displayAddress;
                _isLoading = false;
              });

              _mapController?.animateCamera(
                CameraUpdate.newLatLngZoom(latLng, 16),
              );
              return;
            }
          }
        }
      } catch (_) {}

      setState(() => _isLoading = false);
    }
  }

  /// Maneja tap en el mapa
  void _onMapTap(LatLng location) {
    if (!_MexicoBounds.contains(location)) {
      _showOutsideMexicoError();
      return;
    }

    setState(() {
      _selectedLocation = location;
      _selectedAddress = AppLocalizations.of(context)!.loadingAddress;
    });

    _getAddressFromLatLng(location);
  }

  void _showOutsideMexicoError() {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.location_off, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                l10n.onlyMexicoDestinations,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.errorColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Confirma la selección y regresa
  void _confirmSelection() {
    if (_selectedLocation == null) return;

    if (!_MexicoBounds.contains(_selectedLocation!)) {
      _showOutsideMexicoError();
      return;
    }

    final result = SelectedLocation(
      address: _selectedAddress.isNotEmpty
          ? _selectedAddress
          : 'Ubicación seleccionada',
      latitude: _selectedLocation!.latitude,
      longitude: _selectedLocation!.longitude,
    );

    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          // Mapa
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _selectedLocation ?? _defaultLocation,
              zoom: 15,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            onTap: _onMapTap,
            markers: _selectedLocation != null
                ? {
                    Marker(
                      markerId: const MarkerId('selected'),
                      position: _selectedLocation!,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        widget.isOrigin
                            ? BitmapDescriptor.hueGreen
                            : BitmapDescriptor.hueRed,
                      ),
                    ),
                  }
                : {},
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),

          // Header con búsqueda
          SafeArea(
            child: Column(
              children: [
                _buildSearchHeader(),
                if (_searchResults.isNotEmpty || _isSearching)
                  _buildSearchResults(),
              ],
            ),
          ),

          // Botón de ubicación actual
          Positioned(
            right: 16,
            bottom: 180,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: AppTheme.surfaceColor,
              onPressed: _getCurrentLocation,
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(
                      Icons.my_location,
                      color: AppTheme.primaryLightColor,
                    ),
            ),
          ),

          // Panel inferior con dirección seleccionada
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomPanel(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Título y botón cerrar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 0),
            child: Row(
              children: [
                Icon(
                  widget.isOrigin ? Icons.trip_origin : Icons.location_on,
                  color: widget.isOrigin
                      ? AppTheme.successColor
                      : AppTheme.errorColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close,
                      color: AppTheme.textSecondaryColor),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          // Campo de búsqueda estilo Uber
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocus,
              style: const TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: widget.isOrigin
                    ? AppLocalizations.of(context)!.whereFrom
                    : AppLocalizations.of(context)!.whereGoing,
                hintStyle:
                    const TextStyle(color: AppTheme.textSecondaryColor),
                prefixIcon: _isSearching
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppTheme.primaryLightColor,
                          ),
                        ),
                      )
                    : const Icon(Icons.search,
                        color: AppTheme.textSecondaryColor),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear,
                            color: AppTheme.textSecondaryColor),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchResults = []);
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppTheme.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
              ),
              onChanged: (value) => _searchPlaces(value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      constraints: const BoxConstraints(maxHeight: 280),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 12,
          ),
        ],
      ),
      child: _isSearching && _searchResults.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Builder(
                  builder: (ctx) => Text(
                    AppLocalizations.of(ctx)!.searching,
                    style: const TextStyle(color: AppTheme.textSecondaryColor),
                  ),
                ),
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _searchResults.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                color: AppTheme.dividerColor,
                indent: 56,
              ),
              itemBuilder: (context, index) {
                final place = _searchResults[index];
                return InkWell(
                  onTap: () => _selectPlace(place),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.cardColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.location_on_outlined,
                            color: AppTheme.primaryLightColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Nombre del lugar en bold (estilo Uber)
                              Text(
                                place.mainText,
                                style: const TextStyle(
                                  color: AppTheme.textPrimaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (place.secondaryText.isNotEmpty) ...[
                                const SizedBox(height: 2),
                                // Dirección secundaria más pequeña
                                Text(
                                  place.secondaryText,
                                  style: const TextStyle(
                                    color: AppTheme.textSecondaryColor,
                                    fontSize: 13,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildBottomPanel() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (widget.isOrigin
                            ? AppTheme.successColor
                            : AppTheme.errorColor)
                        .withAlpha(30),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    widget.isOrigin ? Icons.trip_origin : Icons.location_on,
                    color: widget.isOrigin
                        ? AppTheme.successColor
                        : AppTheme.errorColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.isOrigin
                            ? l10n.originPoint
                            : l10n.destinationPoint,
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _selectedAddress.isNotEmpty
                            ? _selectedAddress
                            : l10n.tapMapToSelect,
                        style: const TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed:
                    _selectedLocation != null ? _confirmSelection : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryLightColor,
                  disabledBackgroundColor: AppTheme.dividerColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  widget.isOrigin ? l10n.confirmOrigin : l10n.confirmDestination,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Resultado de búsqueda de Places Autocomplete
class _PlaceResult {
  final String placeId;
  final String mainText;       // Nombre del lugar (bold, estilo Uber)
  final String secondaryText;  // Dirección secundaria (más pequeña)
  final String fullDescription;
  final double? fallbackLat;   // Usado cuando placeId está vacío (geocoding nativo)
  final double? fallbackLng;

  _PlaceResult({
    required this.placeId,
    required this.mainText,
    required this.secondaryText,
    required this.fullDescription,
    this.fallbackLat,
    this.fallbackLng,
  });
}
