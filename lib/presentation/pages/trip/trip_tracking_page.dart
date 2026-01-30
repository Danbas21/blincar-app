import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/trip/trip_entity.dart';
import '../../../domain/repositories/trip_repository.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/services/vehicle_marker_service.dart';
import '../panic/panic_page.dart';
import 'package:dartz/dartz.dart' hide State;
import '../../../core/errors/failures.dart';
import 'package:firebase_database/firebase_database.dart';

class TripTrackingPage extends StatefulWidget {
  final String tripId;

  const TripTrackingPage({
    super.key,
    required this.tripId,
  });

  @override
  State<TripTrackingPage> createState() => _TripTrackingPageState();
}

class _TripTrackingPageState extends State<TripTrackingPage> {
  final TripRepository _tripRepository = getIt<TripRepository>();
  final FirebaseDatabase _database = getIt<FirebaseDatabase>();
  final VehicleMarkerService _vehicleMarkerService = VehicleMarkerService();
  GoogleMapController? _mapController;
  StreamSubscription<Either<Failure, TripEntity>>? _tripSubscription;
  StreamSubscription<DatabaseEvent>? _locationSubscription;

  TripEntity? _currentTrip;
  bool _isLoading = true;
  String? _error;
  bool _hasShownCompletedDialog = false;

  // Ubicación en tiempo real del conductor
  LatLng? _driverLocation;
  double _driverHeading = 0.0;

  // Animación del vehículo
  VehicleAnimationController? _vehicleAnimController;
  BitmapDescriptor? _vehicleMarker;

  // Color del vehículo (puede venir del viaje o configuración)
  VehicleColor _vehicleColor = VehicleColor.black;

  // Map markers
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  // Lista de puntos recorridos para trazar la ruta real
  final List<LatLng> _routePoints = [];

  // Camera position inicial (se actualizará con los datos del viaje)
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(19.4326, -99.1332), // CDMX default
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    _startTripTracking();
    _startDriverLocationTracking();
  }

  @override
  void dispose() {
    _tripSubscription?.cancel();
    _locationSubscription?.cancel();
    _vehicleAnimController?.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void _startTripTracking() {
    _tripSubscription = _tripRepository.watchTrip(widget.tripId).listen(
      (result) {
        result.fold(
          (failure) {
            setState(() {
              _error = failure.message;
              _isLoading = false;
            });
          },
          (trip) {
            
            // Determinar color del vehículo basado en datos del viaje
            _determineVehicleColor(trip);

            setState(() {
              _currentTrip = trip;
              _isLoading = false;
              _error = null;
            });
            _updateMapMarkers(trip);
            _updatePolyline(trip);
            _centerMapOnRoute(trip);

            // Si el viaje se completó, mostrar dialog y cerrar (solo una vez)
            if (trip.status == TripStatus.completed && !_hasShownCompletedDialog) {
                            _hasShownCompletedDialog = true;
              // Usar Future.delayed para evitar llamar a showDialog durante build
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  _showTripCompletedDialog();
                }
              });
            }
          },
        );
      },
    );
  }

  /// 📍 Escucha la ubicación del conductor en tiempo real desde Firebase
  void _startDriverLocationTracking() {
    
    final locationRef = _database.ref('blincar/trips/${widget.tripId}/currentLocation');

    _locationSubscription = locationRef.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        try {
          final data = event.snapshot.value as Map<dynamic, dynamic>;
          final latitude = data['latitude'] as double?;
          final longitude = data['longitude'] as double?;
          final heading = (data['heading'] as num?)?.toDouble() ?? 0.0;

          if (latitude != null && longitude != null) {
            final newPosition = LatLng(latitude, longitude);

            // Inicializar o actualizar el controlador de animación
            if (_vehicleAnimController == null) {
              _vehicleAnimController = VehicleAnimationController(
                initialPosition: newPosition,
                initialHeading: heading,
                onUpdate: _onVehicleAnimationUpdate,
              );
              _driverLocation = newPosition;
              _driverHeading = heading;

              // Agregar punto inicial a la ruta
              _routePoints.add(newPosition);
            } else {
              // Actualizar posición objetivo para animación suave
              _vehicleAnimController!.updateTarget(newPosition, heading);

              // Agregar punto a la ruta si es significativamente diferente
              if (_routePoints.isEmpty ||
                  _calculateDistance(_routePoints.last, newPosition) > 0.00005) {
                _routePoints.add(newPosition);
              }
            }

            // Actualizar el marcador y la polilínea
            _updateVehicleMarker();

                      }
        } catch (e) {
                  }
      }
    }, onError: (error) {
          });
  }

  /// Callback cuando la animación del vehículo se actualiza
  void _onVehicleAnimationUpdate(LatLng position, double heading) {
    if (mounted) {
      setState(() {
        _driverLocation = position;
        _driverHeading = heading;
      });
      _updateVehicleMarker();
    }
  }

  /// Calcula la distancia aproximada entre dos puntos
  double _calculateDistance(LatLng p1, LatLng p2) {
    return ((p1.latitude - p2.latitude).abs() + (p1.longitude - p2.longitude).abs());
  }

  /// Actualiza el marcador del vehículo con rotación
  Future<void> _updateVehicleMarker() async {
    if (_driverLocation == null || _currentTrip == null) return;

    // Obtener el marcador rotado
    _vehicleMarker = await _vehicleMarkerService.getVehicleMarker(
      color: _vehicleColor,
      heading: _driverHeading,
      size: 80,
    );

    if (mounted) {
      setState(() {
        _updateMapMarkers(_currentTrip!);
        _updateRoutePolyline();
      });
    }
  }

  /// Actualiza la polilínea con la ruta real recorrida
  void _updateRoutePolyline() {
    if (_routePoints.length < 2) return;

    // Remover polilínea anterior de ruta recorrida
    _polylines.removeWhere((p) => p.polylineId.value == 'traveled_route');

    // Agregar polilínea de ruta recorrida
    _polylines.add(Polyline(
      polylineId: const PolylineId('traveled_route'),
      points: List.from(_routePoints),
      color: AppTheme.successColor,
      width: 5,
    ));
  }

  void _updateMapMarkers(TripEntity trip) {
    _markers.clear();

    // Marcador de origen
    _markers.add(Marker(
      markerId: const MarkerId('origin'),
      position: LatLng(
        trip.route.origin.latitude,
        trip.route.origin.longitude,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(
        title: 'Origen',
        snippet: trip.route.origin.name,
      ),
    ));

    // Marcador de destino
    _markers.add(Marker(
      markerId: const MarkerId('destination'),
      position: LatLng(
        trip.route.destination.latitude,
        trip.route.destination.longitude,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(
        title: 'Destino',
        snippet: trip.route.destination.name,
      ),
    ));

    // 🚗 Marcador de ubicación del conductor en tiempo real (Camioneta animada)
    if (trip.isActive && trip.driverName != null && _driverLocation != null) {
      _markers.add(Marker(
        markerId: const MarkerId('driver'),
        position: _driverLocation!,
        icon: _vehicleMarker ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(
          title: '${trip.driverName!} 🚐',
          snippet: trip.vehiclePlate ?? 'Suburban Ejecutiva',
        ),
        anchor: const Offset(0.5, 0.5),
        flat: true, // Importante para que la rotación se vea correcta
        rotation: 0, // La rotación ya está aplicada en el icono
      ));
    }
  }

  /// Determina el color del vehículo basado en la información del viaje
  void _determineVehicleColor(TripEntity trip) {
    // Por defecto usamos negro para vehículos ejecutivos
    // Esto puede personalizarse basado en datos del viaje
    // Por ejemplo: trip.vehicleColor o trip.serviceType
    if (trip.vehiclePlate?.toLowerCase().contains('blanco') == true ||
        trip.vehiclePlate?.toLowerCase().contains('white') == true) {
      _vehicleColor = VehicleColor.white;
    } else {
      _vehicleColor = VehicleColor.black;
    }
  }

  /// Alterna el color del vehículo entre blanco y negro
  void _toggleVehicleColor() {
    setState(() {
      _vehicleColor = _vehicleColor == VehicleColor.black
          ? VehicleColor.white
          : VehicleColor.black;
    });
    // Actualizar el marcador con el nuevo color
    _updateVehicleMarker();
  }

  void _updatePolyline(TripEntity trip) {
    _polylines.clear();

    // Crear línea entre origen y destino
    _polylines.add(Polyline(
      polylineId: const PolylineId('route'),
      points: [
        LatLng(trip.route.origin.latitude, trip.route.origin.longitude),
        LatLng(
            trip.route.destination.latitude, trip.route.destination.longitude),
      ],
      color: AppTheme.primaryLightColor,
      width: 4,
      patterns: [PatternItem.dash(20), PatternItem.gap(10)],
    ));
  }

  void _centerMapOnRoute(TripEntity trip) {
    if (_mapController == null) return;

    // Calcular bounds para incluir origen y destino
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        trip.route.origin.latitude < trip.route.destination.latitude
            ? trip.route.origin.latitude
            : trip.route.destination.latitude,
        trip.route.origin.longitude < trip.route.destination.longitude
            ? trip.route.origin.longitude
            : trip.route.destination.longitude,
      ),
      northeast: LatLng(
        trip.route.origin.latitude > trip.route.destination.latitude
            ? trip.route.origin.latitude
            : trip.route.destination.latitude,
        trip.route.origin.longitude > trip.route.destination.longitude
            ? trip.route.origin.longitude
            : trip.route.destination.longitude,
      ),
    );

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 100),
    );
  }

  void _showTripCompletedDialog() {
    if (!mounted) {
            return;
    }

    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: AppTheme.successColor, size: 32),
            SizedBox(width: 12),
            Text(
              'Viaje Completado',
              style: TextStyle(color: AppTheme.textPrimaryColor),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¡Tu viaje ha finalizado con éxito!',
              style: TextStyle(color: AppTheme.textSecondaryColor),
            ),
            const SizedBox(height: 16),
            if (_currentTrip != null) ...[
              _buildInfoRow('Total', '\$${_currentTrip!.totalPrice.toStringAsFixed(2)}'),
              _buildInfoRow('Duración',
                  _formatDuration(_currentTrip!.tripDuration)),
              _buildInfoRow('Distancia',
                  '${_currentTrip!.route.distanceKm.toStringAsFixed(1)} km'),
            ],
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              
              // 🗑️ Limpiar tripId activo del storage
              final storageService = getIt<StorageService>();
              await storageService.clearActiveTripId();
              
              // Cerrar el dialog
              if (mounted) {
                Navigator.of(context).pop();
              }

              // Volver al home (HomePage) removiendo todas las pantallas intermedias
              if (mounted) {
                Navigator.of(context).popUntil((route) {
                                    return route.isFirst;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.successColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) return 'N/A';
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}min';
    }
    return '${minutes}min';
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Prevenir que el usuario salga accidentalmente con el botón back
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        // Mostrar confirmación antes de salir
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppTheme.surfaceColor,
            title: const Text(
              '¿Salir del viaje?',
              style: TextStyle(color: AppTheme.textPrimaryColor),
            ),
            content: const Text(
              'Tu viaje está en curso. ¿Estás seguro de que quieres salir? Podrás regresar desde la página principal.',
              style: TextStyle(color: AppTheme.textSecondaryColor),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Salir',
                  style: TextStyle(color: AppTheme.errorColor),
                ),
              ),
            ],
          ),
        );
        if (shouldPop == true && mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Viaje en Curso'),
          backgroundColor: AppTheme.primaryLightColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 64, color: AppTheme.errorColor),
                      const SizedBox(height: 16),
                      Text(
                        'Error al cargar el viaje',
                        style: const TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _error!,
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : Stack(
                  children: [
                    // Mapa
                    GoogleMap(
                      initialCameraPosition: _initialPosition,
                      markers: _markers,
                      polylines: _polylines,
                      onMapCreated: (controller) {
                        _mapController = controller;
                        if (_currentTrip != null) {
                          _centerMapOnRoute(_currentTrip!);
                        }
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: true,
                      mapToolbarEnabled: false,
                    ),

                    // Panel de información del viaje
                    Positioned(
                      top: 16,
                      left: 16,
                      right: 16,
                      child: _buildTripInfoPanel(),
                    ),

                    // Botón de pánico
                    Positioned(
                      bottom: 24,
                      right: 24,
                      child: _buildPanicButton(),
                    ),
                  ],
                ),
      floatingActionButton: _currentTrip != null && _currentTrip!.isActive
          ? FloatingActionButton.extended(
              onPressed: () {
                // TODO: Implementar finalización de viaje (solo para driver)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Solo el conductor puede finalizar el viaje'),
                  ),
                );
              },
              backgroundColor: AppTheme.warningColor,
              icon: const Icon(Icons.info_outline),
              label: const Text('Esperando finalización'),
            )
          : null,
      ), // Scaffold
    ); // PopScope
  }

  Widget _buildTripInfoPanel() {
    if (_currentTrip == null) return const SizedBox.shrink();

    final trip = _currentTrip!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Estado del viaje
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: trip.isActive
                      ? AppTheme.successColor
                      : trip.isPending
                          ? AppTheme.warningColor
                          : AppTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                trip.isActive
                    ? 'En Curso'
                    : trip.isPending
                        ? 'Pendiente'
                        : 'Asignado',
                style: const TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '\$${trip.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: AppTheme.primaryLightColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const Divider(height: 24),

          // Información del conductor
          if (trip.driverName != null) ...[
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryLightColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.driverName!,
                        style: const TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (trip.driverPhone != null)
                        Text(
                          trip.driverPhone!,
                          style: const TextStyle(
                            color: AppTheme.textSecondaryColor,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
                // Botón para llamar
                IconButton(
                  icon: const Icon(Icons.phone, color: AppTheme.successColor),
                  onPressed: () {
                    // TODO: Implementar llamada
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Llamando al conductor...')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],

          // Información del vehículo con selector de color
          if (trip.vehiclePlate != null) ...[
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _vehicleColor == VehicleColor.black
                        ? const Color(0xFF1A1A1A)
                        : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.primaryLightColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Icon(
                    Icons.directions_car,
                    color: _vehicleColor == VehicleColor.black
                        ? Colors.white
                        : Colors.black87,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Suburban Ejecutiva',
                        style: const TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        trip.vehiclePlate!,
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // Toggle de color de vehículo
                GestureDetector(
                  onTap: _toggleVehicleColor,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1A),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _vehicleColor == VehicleColor.black
                                  ? AppTheme.primaryLightColor
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _vehicleColor == VehicleColor.white
                                  ? AppTheme.primaryLightColor
                                  : Colors.grey,
                              width: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],

          // Ruta
          Row(
            children: [
              const Icon(Icons.location_on, color: AppTheme.errorColor),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.route.origin.name,
                      style: const TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      trip.route.destination.name,
                      style: const TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Distancia y duración estimada
          Row(
            children: [
              const Icon(Icons.straighten,
                  color: AppTheme.textSecondaryColor, size: 16),
              const SizedBox(width: 4),
              Text(
                '${trip.route.distanceKm.toStringAsFixed(1)} km',
                style: const TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.access_time,
                  color: AppTheme.textSecondaryColor, size: 16),
              const SizedBox(width: 4),
              Text(
                '${trip.route.estimatedDurationMinutes} min',
                style: const TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPanicButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PanicPage(),
          ),
        );
      },
      backgroundColor: AppTheme.errorColor,
      icon: const Icon(Icons.warning_rounded, color: Colors.white, size: 28),
      label: const Text(
        'PÁNICO',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      heroTag: 'panic',
    );
  }
}
