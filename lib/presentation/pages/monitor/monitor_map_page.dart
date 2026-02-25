// lib/presentation/pages/monitor/monitor_map_page.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../core/theme/app_theme.dart';

/// Página con mapa en vivo mostrando ubicación de conductores disponibles
class MonitorMapPage extends StatefulWidget {
  const MonitorMapPage({super.key});

  @override
  State<MonitorMapPage> createState() => _MonitorMapPageState();
}

class _MonitorMapPageState extends State<MonitorMapPage> {
  GoogleMapController? _mapController;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  StreamSubscription<DatabaseEvent>? _driversSubscription;
  StreamSubscription<DatabaseEvent>? _activeTripsSubscription;

  final Set<Marker> _markers = {};
  final Map<String, _DriverInfo> _drivers = {};
  final Map<String, _TripInfo> _activeTrips = {};

  // Centro inicial - Ciudad de México
  static const LatLng _initialCenter = LatLng(19.4326, -99.1332);

  bool _isLoading = true;
  bool _showOnlyAvailable = true;

  @override
  void initState() {
    super.initState();
    _startListeningToDrivers();
    _startListeningToActiveTrips();
  }

  @override
  void dispose() {
    _driversSubscription?.cancel();
    _activeTripsSubscription?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  void _startListeningToDrivers() {
    _driversSubscription = _database
        .ref('blincar/drivers')
        .onValue
        .listen((DatabaseEvent event) {
      if (!mounted) return;

      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        _drivers.clear();

        data.forEach((key, value) {
          if (value is Map) {
            final driver = _DriverInfo.fromMap(key.toString(), value);
            _drivers[key.toString()] = driver;
          }
        });

        _updateMarkers();
        setState(() => _isLoading = false);
      } else {
        setState(() {
          _drivers.clear();
          _isLoading = false;
        });
        _updateMarkers();
      }
    }, onError: (error) {
      debugPrint('[MonitorMap] Error escuchando conductores: $error');
      setState(() => _isLoading = false);
    });
  }

  void _startListeningToActiveTrips() {
    _activeTripsSubscription = _database
        .ref('blincar/trips')
        .orderByChild('status')
        .onValue
        .listen((DatabaseEvent event) {
      if (!mounted) return;

      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        _activeTrips.clear();

        data.forEach((key, value) {
          if (value is Map) {
            final status = value['status']?.toString() ?? '';
            if (status == 'assigned' || status == 'inProgress') {
              final trip = _TripInfo.fromMap(key.toString(), value);
              _activeTrips[key.toString()] = trip;
            }
          }
        });

        _updateMarkers();
      }
    }, onError: (error) {
      debugPrint('[MonitorMap] Error escuchando viajes: $error');
    });
  }

  void _updateMarkers() {
    _markers.clear();

    // Agregar marcadores de conductores
    for (final entry in _drivers.entries) {
      final driver = entry.value;

      // Filtrar si solo queremos disponibles
      if (_showOnlyAvailable && !driver.isAvailable) {
        continue;
      }

      // Si el conductor tiene ubicación
      if (driver.latitude != null && driver.longitude != null) {
        _markers.add(Marker(
          markerId: MarkerId('driver_${driver.id}'),
          position: LatLng(driver.latitude!, driver.longitude!),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            driver.isAvailable
                ? BitmapDescriptor.hueGreen
                : driver.currentTripId != null
                    ? BitmapDescriptor.hueOrange
                    : BitmapDescriptor.hueRed,
          ),
          infoWindow: InfoWindow(
            title: driver.fullName,
            snippet: driver.isAvailable
                ? 'Disponible'
                : driver.currentTripId != null
                    ? 'En viaje'
                    : 'No disponible',
          ),
          onTap: () => _showDriverDetails(driver),
        ));
      }
    }

    // Agregar marcadores de viajes activos (origen y destino)
    for (final trip in _activeTrips.values) {
      // Marcador de origen
      if (trip.originLat != null && trip.originLng != null) {
        _markers.add(Marker(
          markerId: MarkerId('trip_origin_${trip.id}'),
          position: LatLng(trip.originLat!, trip.originLng!),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(
            title: 'Origen: ${trip.userName ?? "Pasajero"}',
            snippet: trip.originName ?? 'Punto de recogida',
          ),
        ));
      }

      // Marcador de destino
      if (trip.destLat != null && trip.destLng != null) {
        _markers.add(Marker(
          markerId: MarkerId('trip_dest_${trip.id}'),
          position: LatLng(trip.destLat!, trip.destLng!),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: 'Destino: ${trip.userName ?? "Pasajero"}',
            snippet: trip.destName ?? 'Destino',
          ),
        ));
      }

      // Ubicación actual del conductor en el viaje
      if (trip.currentLat != null && trip.currentLng != null) {
        _markers.add(Marker(
          markerId: MarkerId('trip_driver_${trip.id}'),
          position: LatLng(trip.currentLat!, trip.currentLng!),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          infoWindow: InfoWindow(
            title: trip.driverName ?? 'Conductor',
            snippet: 'Viaje en curso',
          ),
        ));
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _showDriverDetails(_DriverInfo driver) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: driver.isAvailable
                      ? AppTheme.successColor
                      : AppTheme.errorColor,
                  child: Text(
                    driver.fullName.isNotEmpty
                        ? driver.fullName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver.fullName,
                        style: const TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: driver.isAvailable
                              ? AppTheme.successColor.withValues(alpha: 0.2)
                              : AppTheme.errorColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          driver.isAvailable ? 'Disponible' : 'No disponible',
                          style: TextStyle(
                            color: driver.isAvailable
                                ? AppTheme.successColor
                                : AppTheme.errorColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (driver.rating != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.warningColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppTheme.warningColor,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          driver.rating!.toStringAsFixed(1),
                          style: const TextStyle(
                            color: AppTheme.warningColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: AppTheme.dividerColor),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.phone, 'Teléfono', driver.phoneNumber ?? 'N/A'),
            _buildInfoRow(Icons.badge, 'Licencia', driver.licenseNumber ?? 'N/A'),
            _buildInfoRow(Icons.email, 'Email', driver.email ?? 'N/A'),
            if (driver.currentTripId != null)
              _buildInfoRow(
                Icons.directions_car,
                'Viaje Actual',
                driver.currentTripId!,
              ),
            const SizedBox(height: 20),
            if (driver.isAvailable)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _centerOnDriver(driver);
                  },
                  icon: const Icon(Icons.my_location),
                  label: const Text('Centrar en Mapa'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.textSecondaryColor, size: 20),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _centerOnDriver(_DriverInfo driver) {
    if (driver.latitude != null && driver.longitude != null) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(driver.latitude!, driver.longitude!),
          16,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableCount = _drivers.values.where((d) => d.isAvailable).length;
    final busyCount = _drivers.values.where((d) => d.currentTripId != null).length;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Mapa en Vivo'),
        backgroundColor: AppTheme.primaryColor,
        actions: [
          // Toggle para mostrar solo disponibles
          Row(
            children: [
              const Text(
                'Solo disponibles',
                style: TextStyle(fontSize: 12),
              ),
              Switch(
                value: _showOnlyAvailable,
                onChanged: (value) {
                  setState(() {
                    _showOnlyAvailable = value;
                  });
                  _updateMarkers();
                },
                activeTrackColor: AppTheme.successColor.withValues(alpha: 0.5),
                thumbColor: WidgetStatePropertyAll(
                  _showOnlyAvailable ? AppTheme.successColor : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          // Mapa
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: _initialCenter,
                    zoom: 12,
                  ),
                  markers: _markers,
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  myLocationEnabled: false,
                  zoomControlsEnabled: true,
                  mapToolbarEnabled: false,
                ),

          // Panel de estadísticas
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    icon: Icons.person,
                    label: 'Total',
                    value: '${_drivers.length}',
                    color: AppTheme.primaryLightColor,
                  ),
                  _buildStatItem(
                    icon: Icons.check_circle,
                    label: 'Disponibles',
                    value: '$availableCount',
                    color: AppTheme.successColor,
                  ),
                  _buildStatItem(
                    icon: Icons.directions_car,
                    label: 'En Viaje',
                    value: '$busyCount',
                    color: AppTheme.warningColor,
                  ),
                  _buildStatItem(
                    icon: Icons.route,
                    label: 'Viajes Activos',
                    value: '${_activeTrips.length}',
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),

          // Leyenda
          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Leyenda',
                    style: TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildLegendItem(Colors.green, 'Conductor disponible'),
                  _buildLegendItem(Colors.orange, 'Conductor en viaje'),
                  _buildLegendItem(Colors.blue, 'Origen de viaje'),
                  _buildLegendItem(Colors.red, 'Destino de viaje'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondaryColor,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

/// Modelo para información del conductor
class _DriverInfo {
  final String id;
  final String fullName;
  final String? email;
  final String? phoneNumber;
  final String? licenseNumber;
  final double? latitude;
  final double? longitude;
  final bool isAvailable;
  final bool isActive;
  final String? currentTripId;
  final double? rating;

  _DriverInfo({
    required this.id,
    required this.fullName,
    this.email,
    this.phoneNumber,
    this.licenseNumber,
    this.latitude,
    this.longitude,
    this.isAvailable = false,
    this.isActive = false,
    this.currentTripId,
    this.rating,
  });

  factory _DriverInfo.fromMap(String id, Map<dynamic, dynamic> map) {
    final location = map['currentLocation'] as Map<dynamic, dynamic>?;

    return _DriverInfo(
      id: id,
      fullName: map['fullName']?.toString() ?? 'Sin nombre',
      email: map['email']?.toString(),
      phoneNumber: map['phoneNumber']?.toString(),
      licenseNumber: map['licenseNumber']?.toString(),
      latitude: location?['latitude'] as double?,
      longitude: location?['longitude'] as double?,
      isAvailable: map['isAvailable'] == true,
      isActive: map['isActive'] == true,
      currentTripId: map['currentTripId']?.toString(),
      rating: (map['rating'] as num?)?.toDouble(),
    );
  }
}

/// Modelo para información del viaje activo
class _TripInfo {
  final String id;
  final String? userName;
  final String? driverName;
  final double? originLat;
  final double? originLng;
  final String? originName;
  final double? destLat;
  final double? destLng;
  final String? destName;
  final double? currentLat;
  final double? currentLng;
  final String status;

  _TripInfo({
    required this.id,
    this.userName,
    this.driverName,
    this.originLat,
    this.originLng,
    this.originName,
    this.destLat,
    this.destLng,
    this.destName,
    this.currentLat,
    this.currentLng,
    required this.status,
  });

  factory _TripInfo.fromMap(String id, Map<dynamic, dynamic> map) {
    final route = map['route'] as Map<dynamic, dynamic>?;
    final origin = route?['origin'] as Map<dynamic, dynamic>?;
    final dest = route?['destination'] as Map<dynamic, dynamic>?;
    final currentLoc = map['currentLocation'] as Map<dynamic, dynamic>?;

    return _TripInfo(
      id: id,
      userName: map['userName']?.toString(),
      driverName: map['driverName']?.toString(),
      originLat: (origin?['latitude'] as num?)?.toDouble(),
      originLng: (origin?['longitude'] as num?)?.toDouble(),
      originName: origin?['name']?.toString(),
      destLat: (dest?['latitude'] as num?)?.toDouble(),
      destLng: (dest?['longitude'] as num?)?.toDouble(),
      destName: dest?['name']?.toString(),
      currentLat: (currentLoc?['latitude'] as num?)?.toDouble(),
      currentLng: (currentLoc?['longitude'] as num?)?.toDouble(),
      status: map['status']?.toString() ?? 'unknown',
    );
  }
}
