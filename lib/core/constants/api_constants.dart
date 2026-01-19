import '../config/env_config.dart';

class ApiConstants {
  /// URL base de la API (desde .env - debe ser HTTPS en produccion)
  static String get baseUrl => EnvConfig.apiBaseUrl;

  /// URL base para iOS (misma que Android, configurada en .env)
  static String get baseUrlIOS => EnvConfig.apiBaseUrl;

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verify = '/auth/verify';
  static const String logout = '/auth/logout';

  // Trip endpoints
  static const String trips = '/trips';
  static const String createTrip = '/trips/create';
  static const String tripHistory = '/trips/history';

  // Panic endpoints
  static const String panicVolume = '/panic/volume-button';
  static const String panicApp = '/panic/app-button';

  // Payment endpoints
  static const String preauthorize = '/payments/preauthorize';
  static const String confirmCash = '/payments/cash/confirm';
  static const String wallet = '/payments/wallet';

  // Tracking endpoints
  static const String updateLocation = '/tracking/location';
  static const String locationHistory = '/tracking/trip';

  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> authHeaders(String token) => {
        ...headers,
        'Authorization': 'Bearer $token',
      };
}
