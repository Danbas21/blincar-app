// lib/main_monitor.dart
// Entry point para la app de MONITOR (Dispatcher)

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/config/env_config.dart';
import 'core/services/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/monitor/monitor_login_page.dart';
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

  runApp(const MonitorApp());
}

/// Log condicional - solo muestra en debug
void _log(String message) {
  if (kDebugMode) {
    debugPrint('[Monitor] $message');
  }
}

class MonitorApp extends StatelessWidget {
  const MonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blincar Monitor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppTheme.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const MonitorLoginPage(),
    );
  }
}
