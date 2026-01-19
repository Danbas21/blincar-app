// lib/core/constants/camera_constants.dart

import '../config/env_config.dart';

/// Configuracion de camaras Hikvision para Blincar
///
/// Este archivo centraliza toda la configuracion de las camaras
/// de video streaming que se usan en los viajes.
///
/// IMPORTANTE: Las credenciales se cargan desde .env
/// Nunca hardcodear credenciales en el codigo.
class CameraConstants {
  // 📹 CONFIGURACION CAMARA PRINCIPAL (desde .env)
  static String get cameraIp => EnvConfig.cameraIp;
  static int get rtspPort => EnvConfig.cameraRtspPort;
  static String get username => EnvConfig.cameraUsername;
  static String get password => EnvConfig.cameraPassword;

  // 🔗 URL RTSP COMPLETA (desde .env)
  static String get mainStreamUrl => EnvConfig.cameraMainStreamUrl;

  // URL de stream secundario (menor calidad, menor ancho de banda)
  static String get subStreamUrl => EnvConfig.cameraSubStreamUrl;

  // ⚙️ CONFIGURACIÓN DE REPRODUCCIÓN
  static const bool useHardwareAcceleration = true;
  static const int reconnectDelay = 3000; // milliseconds
  static const int bufferSize = 2000; // milliseconds

  // 📱 OPCIONES DE RED
  static const Duration connectionTimeout = Duration(seconds: 10);
  static const int maxRetries = 3;

  /// Obtiene la URL según la calidad deseada
  ///
  /// [highQuality] = true -> Main stream (alta calidad)
  /// [highQuality] = false -> Sub stream (baja calidad, ahorra datos)
  static String getStreamUrl({bool highQuality = true}) {
    return highQuality ? mainStreamUrl : subStreamUrl;
  }

  /// Valida que la cámara sea accesible
  ///
  /// Retorna true si se puede conectar, false en caso contrario
  static Future<bool> testConnection() async {
    // TODO: Implementar ping o conexión de prueba
    // Por ahora retornamos true para desarrollo
    return true;
  }
}

/// CONFIGURACION DE CAMARA:
///
/// Las credenciales de la camara se configuran en el archivo .env:
///   CAMERA_IP=192.168.x.x
///   CAMERA_RTSP_PORT=554
///   CAMERA_USERNAME=admin
///   CAMERA_PASSWORD=tu_password
///
/// Para probar la conexion en VLC:
///   Media > Open Network Stream > rtsp://user:pass@IP:554/Streaming/Channels/101
///
/// Formatos de stream Hikvision:
///   /Streaming/Channels/101 = Main stream (alta calidad)
///   /Streaming/Channels/102 = Sub stream (baja calidad)
