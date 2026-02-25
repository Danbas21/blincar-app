// lib/core/config/env_config.dart

import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuracion centralizada de variables de entorno
///
/// IMPORTANTE: Nunca hardcodear credenciales en el codigo.
/// Todas las configuraciones sensibles deben estar en .env
class EnvConfig {
  EnvConfig._();

  /// Inicializa las variables de entorno
  /// Debe llamarse en main() antes de runApp()
  static Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
  }

  // ========================================
  // API CONFIGURATION
  // ========================================

  /// URL base de la API (debe ser HTTPS en produccion)
  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'https://api.blincar.com';

  /// URL del socket para tiempo real
  static String get socketUrl =>
      dotenv.env['SOCKET_URL'] ?? 'https://api.blincar.com';

  // ========================================
  // STRIPE CONFIGURATION
  // ========================================

  /// Stripe Publishable Key
  /// En produccion usar pk_live_*, en desarrollo pk_test_*
  static String get stripePublishableKey =>
      dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';

  /// Merchant ID para Apple Pay / Google Pay
  static String get stripeMerchantId =>
      dotenv.env['STRIPE_MERCHANT_ID'] ?? 'merchant.com.blincar';

  /// Nombre del comerciante
  static String get stripeMerchantName =>
      dotenv.env['STRIPE_MERCHANT_NAME'] ?? 'Blincar';

  /// Codigo de pais
  static String get stripeCountryCode =>
      dotenv.env['STRIPE_COUNTRY_CODE'] ?? 'MX';

  /// Moneda por defecto
  static String get stripeCurrency =>
      dotenv.env['STRIPE_CURRENCY'] ?? 'MXN';

  // ========================================
  // CAMERA CONFIGURATION (RTSP)
  // ========================================

  /// IP de la camara Hikvision
  static String get cameraIp =>
      dotenv.env['CAMERA_IP'] ?? '';

  /// Puerto RTSP
  static int get cameraRtspPort =>
      int.tryParse(dotenv.env['CAMERA_RTSP_PORT'] ?? '554') ?? 554;

  /// Usuario de la camara
  static String get cameraUsername =>
      dotenv.env['CAMERA_USERNAME'] ?? '';

  /// Password de la camara
  static String get cameraPassword =>
      dotenv.env['CAMERA_PASSWORD'] ?? '';

  /// URL del stream principal (alta calidad)
  static String get cameraMainStreamUrl {
    if (cameraIp.isEmpty || cameraUsername.isEmpty || cameraPassword.isEmpty) {
      return '';
    }
    return 'rtsp://$cameraUsername:$cameraPassword@$cameraIp:$cameraRtspPort/Streaming/Channels/101';
  }

  /// URL del stream secundario (baja calidad)
  static String get cameraSubStreamUrl {
    if (cameraIp.isEmpty || cameraUsername.isEmpty || cameraPassword.isEmpty) {
      return '';
    }
    return 'rtsp://$cameraUsername:$cameraPassword@$cameraIp:$cameraRtspPort/Streaming/Channels/102';
  }

  // ========================================
  // GOOGLE MAPS CONFIGURATION
  // ========================================

  /// API Key de Google Maps (restringida por SHA-1 y package name)
  /// Usada por el Maps SDK nativo (google_maps_flutter)
  static String get googleMapsApiKey =>
      dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';

  /// API Key para llamadas HTTP a Google Places y Geocoding REST API
  /// Esta key NO tiene restricción de Android SHA-1 - solo restricción de API
  /// Habilitar: Places API, Places API (New), Geocoding API
  static String get googlePlacesHttpKey =>
      dotenv.env['GOOGLE_PLACES_HTTP_KEY'] ?? dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';

  // ========================================
  // ENVIRONMENT FLAGS
  // ========================================

  /// Indica si estamos en modo produccion
  static bool get isProduction =>
      dotenv.env['ENVIRONMENT'] == 'production';

  /// Indica si estamos en modo desarrollo
  static bool get isDevelopment =>
      dotenv.env['ENVIRONMENT'] == 'development';

  /// Habilita logs de debug
  static bool get enableDebugLogs =>
      dotenv.env['ENABLE_DEBUG_LOGS'] == 'true';

  // ========================================
  // VALIDATION
  // ========================================

  /// Valida que las configuraciones criticas esten presentes
  static void validateConfig() {
    final missingKeys = <String>[];

    if (stripePublishableKey.isEmpty) {
      missingKeys.add('STRIPE_PUBLISHABLE_KEY');
    }

    if (missingKeys.isNotEmpty) {
      throw Exception(
        'Missing required environment variables: ${missingKeys.join(', ')}\n'
        'Please check your .env file.',
      );
    }
  }

  /// Valida configuracion de camara (opcional)
  static bool isCameraConfigured() {
    return cameraIp.isNotEmpty &&
        cameraUsername.isNotEmpty &&
        cameraPassword.isNotEmpty;
  }
}
