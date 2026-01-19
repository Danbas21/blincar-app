// lib/presentation/pages/location/location_picker_page.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../../core/theme/app_theme.dart';

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

/// Página para seleccionar ubicación estilo Uber
///
/// Uso:
/// ```dart
/// final result = await Navigator.push<SelectedLocation>(
///   context,
///   MaterialPageRoute(
///     builder: (_) => LocationPickerPage(
///       title: 'Seleccionar origen',
///       initialLocation: LatLng(19.4326, -99.1332),
///     ),
///   ),
/// );
/// ```
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
  List<_SearchResult> _searchResults = [];

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
      // Verificar permisos
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        setState(() => _isLoading = false);
        return;
      }

      // Obtener posición
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final newLocation = LatLng(position.latitude, position.longitude);

      setState(() {
        _selectedLocation = newLocation;
        _isLoading = false;
      });

      // Mover cámara
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(newLocation, 16),
      );

      // Obtener direccion
      await _getAddressFromLatLng(newLocation);
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  /// Convierte coordenadas a dirección
  Future<void> _getAddressFromLatLng(LatLng location) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address = _formatAddress(place);
        setState(() {
          _selectedAddress = address;
        });
      }
    } catch (_) {
      setState(() {
        _selectedAddress = '${location.latitude.toStringAsFixed(6)}, ${location.longitude.toStringAsFixed(6)}';
      });
    }
  }

  /// Formatea el placemark a una dirección legible
  String _formatAddress(Placemark place) {
    final parts = <String>[];

    if (place.street != null && place.street!.isNotEmpty) {
      parts.add(place.street!);
    }
    if (place.subLocality != null && place.subLocality!.isNotEmpty) {
      parts.add(place.subLocality!);
    }
    if (place.locality != null && place.locality!.isNotEmpty) {
      parts.add(place.locality!);
    }
    if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
      parts.add(place.administrativeArea!);
    }

    return parts.isNotEmpty ? parts.join(', ') : 'Ubicación seleccionada';
  }

  /// Busca direcciones por texto
  Future<void> _searchAddress(String query) async {
    if (query.length < 3) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() => _isSearching = true);

    try {
      final locations = await locationFromAddress(query);
      final results = <_SearchResult>[];

      for (final loc in locations.take(5)) {
        try {
          final placemarks = await placemarkFromCoordinates(loc.latitude, loc.longitude);
          if (placemarks.isNotEmpty) {
            results.add(_SearchResult(
              address: _formatAddress(placemarks.first),
              location: LatLng(loc.latitude, loc.longitude),
            ));
          }
        } catch (_) {}
      }

      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (_) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
    }
  }

  /// Selecciona una ubicación del resultado de búsqueda
  void _selectSearchResult(_SearchResult result) {
    setState(() {
      _selectedLocation = result.location;
      _selectedAddress = result.address;
      _searchResults = [];
      _searchController.text = result.address;
    });

    _searchFocus.unfocus();

    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(result.location, 16),
    );
  }

  /// Maneja tap en el mapa
  void _onMapTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
      _selectedAddress = 'Cargando dirección...';
    });

    _getAddressFromLatLng(location);
  }

  /// Confirma la selección y regresa
  void _confirmSelection() {
    if (_selectedLocation == null) return;

    final result = SelectedLocation(
      address: _selectedAddress.isNotEmpty ? _selectedAddress : 'Ubicación seleccionada',
      latitude: _selectedLocation!.latitude,
      longitude: _selectedLocation!.longitude,
    );

    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
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
                if (_searchResults.isNotEmpty) _buildSearchResults(),
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
                  : const Icon(Icons.my_location, color: AppTheme.primaryLightColor),
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
                  color: widget.isOrigin ? AppTheme.successColor : AppTheme.errorColor,
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
                  icon: const Icon(Icons.close, color: AppTheme.textSecondaryColor),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          // Campo de búsqueda
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocus,
              style: const TextStyle(color: AppTheme.textPrimaryColor),
              decoration: InputDecoration(
                hintText: 'Buscar dirección...',
                hintStyle: const TextStyle(color: AppTheme.textSecondaryColor),
                prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondaryColor),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: AppTheme.textSecondaryColor),
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              onChanged: (value) {
                _searchAddress(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      constraints: const BoxConstraints(maxHeight: 250),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 10,
          ),
        ],
      ),
      child: _isSearching
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                return ListTile(
                  leading: const Icon(
                    Icons.location_on_outlined,
                    color: AppTheme.textSecondaryColor,
                  ),
                  title: Text(
                    result.address,
                    style: const TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => _selectSearchResult(result),
                );
              },
            ),
    );
  }

  Widget _buildBottomPanel() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
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
            // Indicador
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

            // Dirección seleccionada
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (widget.isOrigin ? AppTheme.successColor : AppTheme.errorColor)
                        .withAlpha(30),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    widget.isOrigin ? Icons.trip_origin : Icons.location_on,
                    color: widget.isOrigin ? AppTheme.successColor : AppTheme.errorColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.isOrigin ? 'Punto de origen' : 'Punto de destino',
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _selectedAddress.isNotEmpty
                            ? _selectedAddress
                            : 'Toca el mapa para seleccionar',
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

            // Botón confirmar
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _selectedLocation != null ? _confirmSelection : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryLightColor,
                  disabledBackgroundColor: AppTheme.dividerColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Confirmar ${widget.isOrigin ? 'origen' : 'destino'}',
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

/// Resultado de búsqueda interno
class _SearchResult {
  final String address;
  final LatLng location;

  _SearchResult({required this.address, required this.location});
}
