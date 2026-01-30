// lib/presentation/pages/trip/trip_request_page_v2.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/routes_data.dart';
import '../../../domain/entities/trip/route_entity.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/services/storage_service.dart';
import '../../../domain/repositories/trip_repository.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/common/custom_button.dart';
import 'waiting_assignment_page.dart';

class TripRequestPageV2 extends StatefulWidget {
  const TripRequestPageV2({super.key});

  @override
  State<TripRequestPageV2> createState() => _TripRequestPageV2State();
}

class _TripRequestPageV2State extends State<TripRequestPageV2> {
  GoogleMapController? _mapController;

  RouteEntity? _selectedRoute;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  String _selectedServiceType = 'Punto a Punto';

  // Tipos de servicio con multiplicadores de precio
  final Map<String, double> _serviceMultipliers = {
    'Punto a Punto': 1.0,
    'Con Escolta Armado': 1.5,
    'Con Escolta Desarmado': 1.3,
    'Auto Blindado': 2.0,
    'Auto Blindado + Escolta': 2.5,
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routesCount = RoutesData.airportRoutes.length;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading:
            false, // No mostrar botón de regreso (está en tab)
        title: Row(
          children: [
            const Icon(Icons.route, color: AppTheme.primaryLightColor),
            const SizedBox(width: 12),
            Text(
              'Rutas Disponibles ($routesCount)',
              style: const TextStyle(color: AppTheme.textPrimaryColor),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Mapa
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                RoutesData.aicmT1.latitude,
                RoutesData.aicmT1.longitude,
              ),
              zoom: 12.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),

          // Panel de selección de ruta
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              decoration: const BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: _selectedRoute == null
                  ? _buildRouteSelector()
                  : _buildRouteDetails(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteSelector() {
    final routes = RoutesData.airportRoutes;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Handle
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.dividerColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),

        // Título
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Selecciona tu ruta',
                style: TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLightColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${routes.length} rutas',
                  style: const TextStyle(
                    color: AppTheme.primaryLightColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Lista de rutas
        if (routes.isEmpty)
          SizedBox(
            height: 300,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppTheme.errorColor,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'No hay rutas disponibles',
                    style: TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Revisa la consola para más detalles',
                    style: TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      // setState(() {
                      //   _debugRoutes();
                      // });
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Recargar rutas'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryLightColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: routes.length,
              itemBuilder: (context, index) {
                final route = routes[index];
                return _buildRouteCard(route);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildRouteCard(RouteEntity route) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRoute = route;
        });
        _updateMap(route);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.dividerColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de la ruta
            Row(
              children: [
                const Icon(
                  Icons.route,
                  color: AppTheme.primaryLightColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    route.name,
                    style: const TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Detalles
            Row(
              children: [
                _buildDetailChip(
                  Icons.straighten,
                  '${route.distanceKm.toStringAsFixed(1)} km',
                ),
                const SizedBox(width: 8),
                _buildDetailChip(
                  Icons.access_time,
                  '${route.estimatedDurationMinutes} min',
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Precio
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.primaryLightColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.attach_money,
                    color: AppTheme.primaryLightColor,
                    size: 20,
                  ),
                  Text(
                    '\$${route.totalPrice.toStringAsFixed(0)} MXN',
                    style: const TextStyle(
                      color: AppTheme.primaryLightColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (route.tollCost != null) ...[
                    const SizedBox(width: 4),
                    const Text(
                      '(incluye casetas)',
                      style: TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.textSecondaryColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteDetails() {
    if (_selectedRoute == null) return const SizedBox();

    final route = _selectedRoute!;
    final selectedMultiplier = _serviceMultipliers[_selectedServiceType] ?? 1.0;
    final finalPrice = route.totalPrice * selectedMultiplier;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
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

            const SizedBox(height: 20),

            // Botón volver
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _selectedRoute = null;
                  _markers.clear();
                  _polylines.clear();
                });
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Cambiar ruta'),
            ),

            const SizedBox(height: 16),

            // Información de la ruta
            Text(
              route.name,
              style: const TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Detalles del trayecto
            _buildInfoRow(
              Icons.location_on,
              'Origen',
              route.origin.name,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.flag,
              'Destino',
              route.destination.name,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.straighten,
              'Distancia',
              '${route.distanceKm.toStringAsFixed(1)} km',
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.access_time,
              'Tiempo estimado',
              '${route.estimatedDurationMinutes} minutos',
            ),

            const SizedBox(height: 24),

            // Selector de tipo de servicio
            const Text(
              'Tipo de servicio',
              style: TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            ..._serviceMultipliers.entries.map((entry) {
              final isSelected = _selectedServiceType == entry.key;
              final price = route.totalPrice * entry.value;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedServiceType = entry.key;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryLightColor.withValues(alpha: 0.1)
                        : AppTheme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.primaryLightColor
                          : AppTheme.dividerColor,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: isSelected
                            ? AppTheme.primaryLightColor
                            : AppTheme.textSecondaryColor,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          entry.key,
                          style: TextStyle(
                            color: isSelected
                                ? AppTheme.primaryLightColor
                                : AppTheme.textPrimaryColor,
                            fontSize: 16,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      Text(
                        '\$${price.toStringAsFixed(0)} MXN',
                        style: TextStyle(
                          color: isSelected
                              ? AppTheme.primaryLightColor
                              : AppTheme.textPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            const SizedBox(height: 24),

            // Resumen de precio
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppTheme.primaryLightColor,
                    Color(0xFF0F4C75),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total a pagar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '\$${finalPrice.toStringAsFixed(0)} MXN',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Botón confirmar
            CustomButton(
              text: 'Solicitar viaje',
              onPressed: () => _confirmTrip(),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppTheme.textSecondaryColor),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _updateMap(RouteEntity route) {
    _markers.clear();
    _polylines.clear();

    // Marcador de origen
    _markers.add(
      Marker(
        markerId: const MarkerId('origin'),
        position: LatLng(route.origin.latitude, route.origin.longitude),
        infoWindow: InfoWindow(title: route.origin.name),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );

    // Marcador de destino
    _markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position:
            LatLng(route.destination.latitude, route.destination.longitude),
        infoWindow: InfoWindow(title: route.destination.name),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    // Línea simple entre origen y destino
    _polylines.add(
      Polyline(
        polylineId: const PolylineId('route'),
        points: [
          LatLng(route.origin.latitude, route.origin.longitude),
          LatLng(route.destination.latitude, route.destination.longitude),
        ],
        color: AppTheme.primaryLightColor,
        width: 4,
      ),
    );

    // Animar cámara para mostrar ambos puntos
    _mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(
            route.origin.latitude < route.destination.latitude
                ? route.origin.latitude
                : route.destination.latitude,
            route.origin.longitude < route.destination.longitude
                ? route.origin.longitude
                : route.destination.longitude,
          ),
          northeast: LatLng(
            route.origin.latitude > route.destination.latitude
                ? route.origin.latitude
                : route.destination.latitude,
            route.origin.longitude > route.destination.longitude
                ? route.origin.longitude
                : route.destination.longitude,
          ),
        ),
        100, // padding
      ),
    );

    setState(() {});
  }

  void _confirmTrip() async {
    if (_selectedRoute == null) return;

    // Obtener usuario actual
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Debes iniciar sesión')),
        );
      }
      return;
    }

    final user = authState.user;

    // Mostrar loading
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Crear viaje en Firebase
    final tripRepository = getIt<TripRepository>();
    final selectedMultiplier = _serviceMultipliers[_selectedServiceType] ?? 1.0;
    final finalPrice = _selectedRoute!.totalPrice * selectedMultiplier;

    final result = await tripRepository.createTripRequest(
      userId: user.id,
      userName: user.fullName,
      userPhone: user.phoneNumber,
      routeId: _selectedRoute!.id,
      serviceType: _selectedServiceType,
      totalPrice: finalPrice,
    );

    // Cerrar loading
    if (mounted) {
      Navigator.of(context).pop();
    }

    // Manejar resultado
    result.fold(
      (failure) {
        // Error creando viaje
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(failure.message)),
          );
        }
      },
      (trip) async {
        // Viaje creado exitosamente

        // 💾 Guardar tripId activo para poder recuperarlo si sale de la app
        final storageService = getIt<StorageService>();
        await storageService.saveActiveTripId(trip.id);

        if (mounted) {
          // Navegar a pantalla de espera (usar push, no pushReplacement)
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WaitingAssignmentPage(tripId: trip.id),
            ),
          );
        }
      },
    );
  }
}
