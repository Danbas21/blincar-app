// lib/data/datasources/stripe/stripe_datasource.dart

import 'package:blincar_app/core/errors/failures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

/// DataSource para operaciones de Stripe
abstract interface class StripeDataSource {
  /// Tokeniza una tarjeta con Stripe
  Future<String> tokenizeCard({
    required String cardNumber,
    required String expiryMonth,
    required String expiryYear,
    required String cvv,
  });

  /// Crea un Payment Intent y presenta el Payment Sheet
  Future<bool> processPayment({
    required String clientSecret,
  });

  /// Inicializa Payment Sheet con configuracion
  Future<void> initializePaymentSheet({
    required String clientSecret,
    String? customerId,
    String? ephemeralKey,
  });
}

class StripeDataSourceImpl implements StripeDataSource {
  final Stripe stripe;

  const StripeDataSourceImpl({required this.stripe});

  @override
  Future<String> tokenizeCard({
    required String cardNumber,
    required String expiryMonth,
    required String expiryYear,
    required String cvv,
  }) async {
    try {
      // Crear token de tarjeta usando Stripe
      final cardParams = CardTokenParams(
        type: TokenType.Card,
        name: null, // Se pasa desde el repository
      );

      // Crear token
      final tokenData = await stripe.createToken(
        CreateTokenParams.card(
          params: cardParams,
        ),
      );

      return tokenData.id;
    } on StripeException catch (e) {
      throw TokenizationException(
        message: e.error.localizedMessage ?? 'Error al tokenizar la tarjeta',
        code: e.error.code.name,
        originalError: e,
      );
    } catch (e) {
      throw TokenizationException(
        message: 'Error inesperado al tokenizar la tarjeta',
        originalError: e,
      );
    }
  }

  @override
  Future<void> initializePaymentSheet({
    required String clientSecret,
    String? customerId,
    String? ephemeralKey,
  }) async {
    try {
      await stripe.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Blincar',
          customerId: customerId,
          customerEphemeralKeySecret: ephemeralKey,
          style: ThemeMode.system,
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'MX',
            currencyCode: 'MXN',
            testEnv: true, // ⚠️ Cambiar a false en produccion
          ),
          applePay: const PaymentSheetApplePay(
            merchantCountryCode: 'MX',
          ),
        ),
      );
    } on StripeException catch (e) {
      throw PaymentServerException(
        message: e.error.localizedMessage ?? 'Error al inicializar el pago',
        code: e.error.code.name,
        originalError: e,
      );
    }
  }

  @override
  Future<bool> processPayment({
    required String clientSecret,
  }) async {
    try {
      // Presentar Payment Sheet
      await stripe.presentPaymentSheet();
      return true;
    } on StripeException catch (e) {
      // El usuario cancelo
      if (e.error.code == FailureCode.Canceled) {
        throw const PaymentCancelledException();
      }

      // Pago rechazado
      if (e.error.code == FailureCode.Failed) {
        throw PaymentDeclinedException(
          message: e.error.localizedMessage ?? 'Pago rechazado',
          originalError: e,
        );
      }

      // Otro error
      throw PaymentServerException(
        message: e.error.localizedMessage ?? 'Error al procesar el pago',
        code: e.error.code.name,
        originalError: e,
      );
    }
  }
}

