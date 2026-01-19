// lib/main_driver.dart
// Entry point para la app de CONDUCTOR (Driver)

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/config/env_config.dart';
import 'core/services/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/driver/driver_login_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔐 Cargar variables de entorno
  try {
    await EnvConfig.initialize();
    _log('Variables de entorno cargadas');
  } catch (e) {
    _log('Error cargando .env: $e');
  }

  // 🔥 Inicializar Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _log('Firebase inicializado correctamente');
  } catch (e) {
    _log('Error al inicializar Firebase: $e');
  }

  // Setup de dependencias (DEBE ser await)
  await setupServiceLocator();

  runApp(const DriverApp());
}

/// Log condicional - solo muestra en debug
void _log(String message) {
  if (kDebugMode) {
    debugPrint('[Driver] $message');
  }
}

class DriverApp extends StatelessWidget {
  const DriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blincar Driver',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppTheme.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppTheme.successColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const DriverLoginPage(),
    );
  }
}
