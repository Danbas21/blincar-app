// lib/presentation/pages/trip/trip_request_page_simple.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/custom_button.dart';

/// Versión SIMPLE de solicitud de viaje
/// Todo hardcodeado inline - SIN dependencias externas
class TripRequestPageSimple extends StatefulWidget {
  const TripRequestPageSimple({super.key});

  @override
  State<TripRequestPageSimple> createState() => _TripRequestPageSimpleState();
}

class _TripRequestPageSimpleState extends State<TripRequestPageSimple> {
  // ignore: unused_field - Se usará para controlar cámara del mapa
  GoogleMapController? _mapController;
  // ignore: unused_field - Se usará para resaltar ruta seleccionada
  int? _selectedRouteIndex;

  // 🔥 RUTAS HARDCODEADAS INLINE (del Excel real)
  final List<Map<String, dynamic>> routes = [
    {
      'name': 'AICM → Polanco',
      'distance': '19 km',
      'time': '48 min',
      'price': 3900,
    },
    {
      'name': 'AICM → Santa Fe',
      'distance': '18 km',
      'time': '62 min',
      'price': 4680,
    },
    {
      'name': 'AICM → Reforma',
      'distance': '12 km',
      'time': '38 min',
      'price': 3510,
    },
    {
      'name': 'AICM → Condesa-Roma',
      'distance': '15 km',
      'time': '45 min',
      'price': 4290,
    },
    {
      'name': 'AICM → WTC',
      'distance': '13 km',
      'time': '40 min',
      'price': 3900,
    },
    {
      'name': 'AICM → Zócalo',
      'distance': '8 km',
      'time': '25 min',
      'price': 4290,
    },
    {
      'name': 'AICM → Auditorio Nacional',
      'distance': '17 km',
      'time': '50 min',
      'price': 3900,
    },
    {
      'name': 'AICM → Foro Sol',
      'distance': '6 km',
      'time': '20 min',
      'price': 5070,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          // Mapa
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(19.4363, -99.0721), // AICM
              zoom: 12.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),

          // Panel de rutas
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: const BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
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
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Selecciona tu ruta',
                      style: TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // ✅ Lista de rutas CON PADDING
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: routes.length,
                      itemBuilder: (context, index) {
                        final route = routes[index];
                        return _buildRouteCard(route, index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Botón volver
          Positioned(
            top: 50,
            left: 20,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: AppTheme.surfaceColor,
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.arrow_back,
                color: AppTheme.primaryLightColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteCard(Map<String, dynamic> route, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRouteIndex = index;
        });
        _showRouteDetails(route);
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
            // Nombre de la ruta
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
                    route['name'],
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
                _buildChip(Icons.straighten, route['distance']),
                const SizedBox(width: 8),
                _buildChip(Icons.access_time, route['time']),
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
                    '\$${route['price']} MXN',
                    style: const TextStyle(
                      color: AppTheme.primaryLightColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(IconData icon, String text) {
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

  void _showRouteDetails(Map<String, dynamic> route) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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

            // Título
            Text(
              route['name'],
              style: const TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Info
            _buildInfoRow(Icons.straighten, 'Distancia', route['distance']),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.access_time, 'Tiempo', route['time']),
            const SizedBox(height: 12),
            _buildInfoRow(
                Icons.attach_money, 'Precio', '\$${route['price']} MXN'),

            const SizedBox(height: 30),

            // Botón
            CustomButton(
              text: 'Solicitar viaje',
              onPressed: () {
                Navigator.pop(context);
                _showSuccessDialog();
              },
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
        Text(
          '$label: ',
          style: const TextStyle(
            color: AppTheme.textSecondaryColor,
            fontSize: 16,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: const Text(
          '¡Viaje solicitado!',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
        content: const Text(
          'Tu viaje ha sido solicitado.\n\nUn operador asignará un conductor en breve.',
          style: TextStyle(color: AppTheme.textSecondaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar diálogo
              Navigator.of(context).pop(); // Volver a home
            },
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }
}
