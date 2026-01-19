import '../config/env_config.dart';

class AppConstants {
  // API Configuration (desde .env - debe ser HTTPS en produccion)
  static String get baseUrl => EnvConfig.apiBaseUrl;
  static String get socketUrl => EnvConfig.socketUrl;

  // Endpoints
  static const String authEndpoint = '/auth';
  static const String tripsEndpoint = '/trips';
  static const String panicEndpoint = '/panic';
  static const String recordingsEndpoint = '/recordings';
  static const String paymentsEndpoint = '/payments';
  static const String reservationsEndpoint = '/reservations';
  static const String notificationsEndpoint = '/notifications';
  static const String routesEndpoint = '/routes';
  static const String trackingEndpoint = '/tracking';

  // App Configuration
  static const String appName = 'Blincar';
  static const String appVersion = '1.0.0';

  // GPS Configuration
  static const int locationUpdateIntervalSeconds = 10;
  static const double geofencingRadiusMeters = 100.0;

  // Panic Button Configuration
  static const int panicButtonHoldDuration = 6; // seconds

  // Recording Configuration
  static const String recordingQuality = '4K';

  // Payment Configuration
  static const double defaultCommissionPercentage = 15.0;

  // Service Types
  static const List<String> serviceTypes = [
    'Viaje Ahora',
    'Viaje por Hora',
    'Viaje por Días',
    'Auto con Chofer',
    'Auto Blindado',
    'Auto con Escolta Armado',
    'Auto con Escolta Desarmado',
  ];
}
