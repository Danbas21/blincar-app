// lib/core/security/ssl_pinning_service.dart

import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Servicio de SSL Pinning para proteger contra ataques MITM
///
/// Implementa Certificate Pinning validando el SHA-256 fingerprint
/// del certificado del servidor contra una lista de fingerprints conocidos.
///
/// USO:
/// ```dart
/// final dio = Dio();
/// SslPinningService.configureDio(dio);
/// ```
class SslPinningService {
  /// Fingerprints SHA-256 de los certificados permitidos
  ///
  /// IMPORTANTE: Actualizar estos valores cuando se renueven los certificados
  /// del servidor. Incluir el certificado actual Y el próximo para evitar
  /// interrupciones durante la renovación.
  ///
  /// Para obtener el fingerprint de un dominio:
  /// ```bash
  /// echo | openssl s_client -servername blin-car.com -connect blin-car.com:443 2>/dev/null | \
  ///   openssl x509 -fingerprint -sha256 -noout
  /// ```
  static const List<String> _allowedFingerprints = [
    // Certificado SSL de blin-car.com (SHA-256)
    // Actualizado: Enero 2026
    '79B48F313E874C762FB47C443A2E7A6B9A367C3A618ED7D6B706C6AFCB4744C7',

    // Public Key pinning (backup - más estable en renovaciones)
    '5D6EA374D772F6D1952EA8A0E063F5F8162EF53BF19D7DF166254B4309761A08',

    // IMPORTANTE: Cuando renueves el certificado SSL del servidor,
    // agrega el nuevo fingerprint ANTES de eliminar el anterior
    // para evitar interrupciones del servicio.
  ];

  /// Dominios permitidos para SSL Pinning
  static const List<String> _pinnedDomains = [
    'blin-car.com',
    'api.blincar.com',
  ];

  /// Indica si SSL Pinning está habilitado
  ///
  /// Se deshabilita en modo debug para facilitar desarrollo
  /// IMPORTANTE: Siempre habilitado en release
  static bool get isEnabled {
    // En release siempre habilitado
    if (kReleaseMode) return true;

    // En debug, verificar si hay fingerprints configurados
    return _allowedFingerprints.isNotEmpty;
  }

  /// Configura Dio con SSL Pinning
  ///
  /// Debe llamarse después de crear la instancia de Dio
  /// y antes de realizar cualquier request.
  static void configureDio(Dio dio) {
    if (!isEnabled) {
      debugPrint('⚠️ SSL Pinning DESHABILITADO (modo desarrollo)');
      return;
    }

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();

        // Configurar validación de certificado
        client.badCertificateCallback = (cert, host, port) {
          return _validateCertificate(cert, host);
        };

        return client;
      },
    );

    debugPrint('🔒 SSL Pinning HABILITADO para: ${_pinnedDomains.join(", ")}');
  }

  /// Valida el certificado del servidor
  ///
  /// Retorna true si el certificado es válido, false si debe rechazarse
  static bool _validateCertificate(X509Certificate cert, String host) {
    // Si el host no está en la lista de dominios pinneados, permitir
    // (esto permite que otros dominios funcionen normalmente)
    if (!_isPinnedDomain(host)) {
      return true;
    }

    // Obtener fingerprint SHA-256 del certificado
    final fingerprint = _getCertificateFingerprint(cert);

    // Validar contra la lista de fingerprints permitidos
    final isValid = _allowedFingerprints.contains(fingerprint);

    if (!isValid) {
      debugPrint('❌ SSL Pinning FALLÓ para $host');
      debugPrint('   Fingerprint recibido: $fingerprint');
      debugPrint('   Fingerprints permitidos: $_allowedFingerprints');
    } else {
      debugPrint('✅ SSL Pinning OK para $host');
    }

    return isValid;
  }

  /// Verifica si el host está en la lista de dominios pinneados
  static bool _isPinnedDomain(String host) {
    return _pinnedDomains.any((domain) =>
      host == domain || host.endsWith('.$domain')
    );
  }

  /// Obtiene el fingerprint SHA-256 del certificado
  static String _getCertificateFingerprint(X509Certificate cert) {
    final derBytes = cert.der;
    final digest = sha256.convert(derBytes);
    return digest.toString().toUpperCase();
  }

  /// Obtiene el fingerprint de un certificado para debug/configuración
  ///
  /// Útil para obtener el fingerprint inicial del servidor
  static Future<String?> getServerFingerprint(String url) async {
    try {
      final uri = Uri.parse(url);
      final client = HttpClient();

      String? fingerprint;

      client.badCertificateCallback = (cert, host, port) {
        fingerprint = _getCertificateFingerprint(cert);
        debugPrint('📋 Fingerprint del servidor $host:');
        debugPrint('   $fingerprint');
        return true; // Permitir para obtener el fingerprint
      };

      final request = await client.getUrl(uri);
      final response = await request.close();
      await response.drain();
      client.close();

      return fingerprint;
    } catch (e) {
      debugPrint('Error obteniendo fingerprint: $e');
      return null;
    }
  }

  /// Agrega un fingerprint dinámicamente (para testing)
  ///
  /// NO usar en producción - los fingerprints deben estar hardcodeados
  @visibleForTesting
  static void addFingerprintForTesting(String fingerprint) {
    if (!kReleaseMode) {
      // ignore: invalid_use_of_visible_for_testing_member
      (_allowedFingerprints as List<String>).add(fingerprint);
    }
  }
}

/// Excepción lanzada cuando falla la validación SSL
class SslPinningException implements Exception {
  final String message;
  final String host;
  final String? receivedFingerprint;

  const SslPinningException({
    required this.message,
    required this.host,
    this.receivedFingerprint,
  });

  @override
  String toString() => 'SslPinningException: $message (host: $host)';
}

/// Cliente HTTP seguro con SSL Pinning para uso con paquete http
///
/// Uso:
/// ```dart
/// final client = SslPinningService.createSecureClient();
/// final response = await client.get(Uri.parse('https://api.example.com'));
/// ```
class SecureHttpClient extends http.BaseClient {
  final HttpClient _inner;

  SecureHttpClient._(this._inner);

  /// Crea un cliente HTTP seguro con SSL Pinning
  static SecureHttpClient create() {
    final httpClient = HttpClient();

    if (SslPinningService.isEnabled) {
      httpClient.badCertificateCallback = (cert, host, port) {
        return SslPinningService._validateCertificate(cert, host);
      };
    }

    return SecureHttpClient._(httpClient);
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final ioRequest = await _inner.openUrl(request.method, request.url);

    // Copiar headers
    request.headers.forEach((name, value) {
      ioRequest.headers.set(name, value);
    });

    // Enviar body si existe
    if (request is http.Request && request.bodyBytes.isNotEmpty) {
      ioRequest.add(request.bodyBytes);
    }

    final response = await ioRequest.close();

    // Convertir headers
    final headers = <String, String>{};
    response.headers.forEach((name, values) {
      headers[name] = values.join(',');
    });

    return http.StreamedResponse(
      response,
      response.statusCode,
      headers: headers,
      reasonPhrase: response.reasonPhrase,
      request: request,
    );
  }

  @override
  void close() {
    _inner.close();
  }
}
