// lib/core/services/stripe_backend_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/api_constants.dart';
import 'storage_service.dart';
import 'service_locator.dart';

/// Servicio para conectar con los endpoints de Stripe del backend
class StripeBackendService {
  final String baseUrl;
  final StorageService _storageService;
  final FirebaseAuth _firebaseAuth;

  StripeBackendService({
    String? baseUrl,
    StorageService? storageService,
    FirebaseAuth? firebaseAuth,
  })  : baseUrl = baseUrl ?? ApiConstants.baseUrl,
        _storageService = storageService ?? getIt<StorageService>(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  /// Headers con autenticacion usando Firebase ID Token
  Future<Map<String, String>> get _headers async {
    String? token;

    // Intentar obtener Firebase ID Token
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      token = await currentUser.getIdToken();
    }

    // Fallback al token guardado en storage
    token ??= _storageService.getToken();

    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// Obtener la publishable key de Stripe
  Future<String?> getPublishableKey() async {
    try {
      final headers = await _headers;
      final response = await http.get(
        Uri.parse('$baseUrl/api/stripe/config'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']['publishableKey'];
      }
      return null;
    } catch (e) {
      print('Error obteniendo publishable key: $e');
      return null;
    }
  }

  /// Crear o obtener el Stripe Customer del usuario
  Future<StripeResult<String>> getOrCreateCustomer() async {
    try {
      final headers = await _headers;
      final response = await http.post(
        Uri.parse('$baseUrl/api/stripe/customer'),
        headers: headers,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return StripeResult.success(data['data']['customerId']);
      }

      return StripeResult.error(data['message'] ?? 'Error creando customer');
    } catch (e) {
      return StripeResult.error('Error de conexion: $e');
    }
  }

  /// Crear SetupIntent para agregar tarjeta de forma segura
  Future<StripeResult<SetupIntentData>> createSetupIntent() async {
    try {
      final headers = await _headers;
      final response = await http.post(
        Uri.parse('$baseUrl/api/stripe/setup-intent'),
        headers: headers,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return StripeResult.success(SetupIntentData(
          clientSecret: data['data']['clientSecret'],
          setupIntentId: data['data']['setupIntentId'],
        ));
      }

      return StripeResult.error(data['message'] ?? 'Error creando setup intent');
    } catch (e) {
      return StripeResult.error('Error de conexion: $e');
    }
  }

  /// Agregar tarjeta al Customer usando PaymentMethod ID
  Future<StripeResult<SavedCard>> attachPaymentMethod(String paymentMethodId) async {
    try {
      final headers = await _headers;
      final response = await http.post(
        Uri.parse('$baseUrl/api/stripe/payment-method'),
        headers: headers,
        body: jsonEncode({'paymentMethodId': paymentMethodId}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return StripeResult.success(SavedCard.fromJson(data['data']));
      }

      return StripeResult.error(data['message'] ?? 'Error agregando tarjeta');
    } catch (e) {
      return StripeResult.error('Error de conexion: $e');
    }
  }

  /// Listar tarjetas guardadas del usuario
  Future<StripeResult<List<SavedCard>>> listPaymentMethods() async {
    try {
      final headers = await _headers;
      final response = await http.get(
        Uri.parse('$baseUrl/api/stripe/payment-methods'),
        headers: headers,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> methodsJson = data['data']['paymentMethods'] ?? [];
        final methods = methodsJson.map((m) => SavedCard.fromJson(m)).toList();
        return StripeResult.success(methods);
      }

      return StripeResult.error(data['message'] ?? 'Error obteniendo tarjetas');
    } catch (e) {
      return StripeResult.error('Error de conexion: $e');
    }
  }

  /// Establecer tarjeta como default
  Future<StripeResult<void>> setDefaultPaymentMethod(String paymentMethodId) async {
    try {
      final headers = await _headers;
      final response = await http.put(
        Uri.parse('$baseUrl/api/stripe/payment-method/$paymentMethodId/default'),
        headers: headers,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return StripeResult.success(null);
      }

      return StripeResult.error(data['message'] ?? 'Error actualizando tarjeta');
    } catch (e) {
      return StripeResult.error('Error de conexion: $e');
    }
  }

  /// Eliminar tarjeta
  Future<StripeResult<void>> deletePaymentMethod(String paymentMethodId) async {
    try {
      final headers = await _headers;
      final response = await http.delete(
        Uri.parse('$baseUrl/api/stripe/payment-method/$paymentMethodId'),
        headers: headers,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return StripeResult.success(null);
      }

      return StripeResult.error(data['message'] ?? 'Error eliminando tarjeta');
    } catch (e) {
      return StripeResult.error('Error de conexion: $e');
    }
  }

  /// Procesar pago con tarjeta
  Future<StripeResult<PaymentResultData>> processPayment({
    required double amount,
    required String paymentMethodId,
    String? tripId,
  }) async {
    try {
      final headers = await _headers;
      final response = await http.post(
        Uri.parse('$baseUrl/api/stripe/payment-intent'),
        headers: headers,
        body: jsonEncode({
          'amount': amount,
          'paymentMethodId': paymentMethodId,
          'tripId': tripId,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return StripeResult.success(PaymentResultData(
          success: true,
          paymentIntentId: data['data']['paymentIntentId'],
          status: data['data']['status'],
        ));
      } else if (response.statusCode == 202) {
        // Requiere accion adicional (3D Secure)
        return StripeResult.success(PaymentResultData(
          success: false,
          paymentIntentId: data['data']['paymentIntentId'],
          status: data['data']['status'],
          clientSecret: data['data']['clientSecret'],
          requiresAction: true,
        ));
      }

      return StripeResult.error(data['message'] ?? 'Error procesando pago');
    } catch (e) {
      return StripeResult.error('Error de conexion: $e');
    }
  }

  /// Agregar tarjeta usando el CardField de Flutter Stripe
  /// Este metodo integra con el SDK de Stripe para tokenizar la tarjeta
  Future<StripeResult<SavedCard>> addCardWithStripeSDK() async {
    try {
      // 1. Obtener o crear customer
      final customerResult = await getOrCreateCustomer();
      if (!customerResult.isSuccess) {
        return StripeResult.error(customerResult.error!);
      }

      // 2. Crear SetupIntent
      final setupResult = await createSetupIntent();
      if (!setupResult.isSuccess) {
        return StripeResult.error(setupResult.error!);
      }

      // 3. Confirmar el SetupIntent con el SDK de Stripe
      // Esto abre el formulario seguro de tarjeta
      final setupIntent = await Stripe.instance.confirmSetupIntent(
        paymentIntentClientSecret: setupResult.data!.clientSecret,
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );

      if (setupIntent.status == PaymentIntentsStatus.Succeeded) {
        // 4. Obtener los datos de la tarjeta guardada
        final listResult = await listPaymentMethods();
        if (listResult.isSuccess && listResult.data!.isNotEmpty) {
          // Retornar la tarjeta mas reciente
          return StripeResult.success(listResult.data!.first);
        }
      }

      return StripeResult.error('Error confirmando tarjeta');
    } catch (e) {
      return StripeResult.error('Error: ${e.toString()}');
    }
  }
}

/// Resultado de operaciones de Stripe
class StripeResult<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  StripeResult._({this.data, this.error, required this.isSuccess});

  factory StripeResult.success(T? data) => StripeResult._(data: data, isSuccess: true);
  factory StripeResult.error(String error) => StripeResult._(error: error, isSuccess: false);
}

/// Datos del SetupIntent
class SetupIntentData {
  final String clientSecret;
  final String setupIntentId;

  SetupIntentData({required this.clientSecret, required this.setupIntentId});
}

/// Tarjeta guardada
class SavedCard {
  final String id;
  final String brand;
  final String last4;
  final int expMonth;
  final int expYear;
  final bool isDefault;

  SavedCard({
    required this.id,
    required this.brand,
    required this.last4,
    required this.expMonth,
    required this.expYear,
    this.isDefault = false,
  });

  factory SavedCard.fromJson(Map<String, dynamic> json) {
    return SavedCard(
      id: json['id'] ?? '',
      brand: json['brand'] ?? 'unknown',
      last4: json['last4'] ?? '****',
      expMonth: json['expMonth'] ?? 0,
      expYear: json['expYear'] ?? 0,
      isDefault: json['isDefault'] ?? false,
    );
  }

  String get expiryDate => '${expMonth.toString().padLeft(2, '0')}/${expYear.toString().substring(2)}';

  String get displayName {
    switch (brand.toLowerCase()) {
      case 'visa':
        return 'Visa';
      case 'mastercard':
        return 'Mastercard';
      case 'amex':
      case 'american_express':
        return 'American Express';
      default:
        return brand.toUpperCase();
    }
  }
}

/// Resultado del pago
class PaymentResultData {
  final bool success;
  final String? paymentIntentId;
  final String? status;
  final String? clientSecret;
  final bool requiresAction;

  PaymentResultData({
    required this.success,
    this.paymentIntentId,
    this.status,
    this.clientSecret,
    this.requiresAction = false,
  });
}
