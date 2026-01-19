// lib/presentation/pages/dev/dev_tools_page.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/firebase_seeder.dart';

/// Página temporal para herramientas de desarrollo
///
/// ⚠️ SOLO PARA DEMO - Eliminar en producción
class DevToolsPage extends StatefulWidget {
  const DevToolsPage({super.key});

  @override
  State<DevToolsPage> createState() => _DevToolsPageState();
}

class _DevToolsPageState extends State<DevToolsPage> {
  bool _isLoading = false;
  String _status = 'Listo para cargar datos';

  Future<void> _seedDatabase() async {
    setState(() {
      _isLoading = true;
      _status = 'Cargando datos en Firebase...';
    });

    try {
      final seeder = FirebaseSeeder();
      final success = await seeder.seedDatabase();

      setState(() {
        _isLoading = false;
        _status = success
            ? '✅ Datos cargados exitosamente!\n\nVehículos, conductores y paquetes disponibles.'
            : '❌ Error al cargar datos. Revisa los logs.';
      });

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Firebase seed completado'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _status = '❌ Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.surfaceColor,
        title: const Text(
          '🛠️ Dev Tools',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.warningColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.warningColor),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning_amber, color: AppTheme.warningColor),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Solo para DEMO - Eliminar en producción',
                      style: TextStyle(
                        color: AppTheme.warningColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              'Firebase Seed Data',
              style: TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Carga datos de prueba en Firebase:\n'
              '• 7 vehículos\n'
              '• 3 conductores\n'
              '• 6 paquetes de servicio',
              style: TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 32),

            // Botón de seed
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _seedDatabase,
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : const Icon(Icons.upload),
              label: Text(_isLoading ? 'Cargando...' : '🌱 Cargar Seed Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryLightColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Status
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppTheme.primaryLightColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Estado',
                        style: TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _status,
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Warning adicional
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '⚠️ Esto eliminará datos existentes en Firebase',
                style: TextStyle(
                  color: AppTheme.errorColor,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
