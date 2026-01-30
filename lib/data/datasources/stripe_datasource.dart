// lib/data/datasources/stripe_datasource.dart

import 'package:flutter_stripe/flutter_stripe.dart';
import '../../core/errors/failures.dart';

/// DataSource para operaciones con Stripe
abstract class StripeDataSource {
  /// Crea un PaymentMethod en Stripe
  Future<String> createPaymentMethod({
    required String cardNumber,
    required String expiryMonth,
    required String expiryYear,
    required String cvv,
    required String cardHolderName,
  });

  /// Obtiene ultimos 4 digitos del payment method
  String getLastFourDigits(String paymentMethodId);

  /// Obtiene la marca de la tarjeta
  String getCardBrand(String paymentMethodId);
}

class StripeDataSourceImpl implements StripeDataSource {
  final Stripe stripe;

  const StripeDataSourceImpl({required this.stripe});

  @override
  Future<String> createPaymentMethod({
    required String cardNumber,
    required String expiryMonth,
    required String expiryYear,
    required String cvv,
    required String cardHolderName,
  }) async {
    try {
      final tokenData = await stripe.createToken(
        CreateTokenParams.card(
          params: CardTokenParams(
            type: TokenType.Card,
            name: cardHolderName,
          ),
        ),
      );
      // Crear PaymentMethod
      final paymentMethod = await stripe.createPaymentMethod(
        params: PaymentMethodParams.cardFromToken(
          paymentMethodData: PaymentMethodDataCardFromToken(
            token: tokenData.id,
          ),
        ),
      );

      return paymentMethod.id;
    } on StripeException catch (e) {
      throw PaymentFailure(
        e.error.localizedMessage ?? 'Error al procesar la tarjeta',
        paymentErrorCode: e.error.code.name,
      );
    } catch (e) {
      throw PaymentFailure('Error inesperado al tokenizar la tarjeta');
    }
  }

  @override
  String getLastFourDigits(String paymentMethodId) {
    // En producción, esto vendría del objeto PaymentMethod
    // Por ahora retornamos un placeholder
    return paymentMethodId.substring(paymentMethodId.length - 4);
  }

  @override
  String getCardBrand(String paymentMethodId) {
    // En producción, esto vendría del objeto PaymentMethod
    return 'visa'; // Placeholder
  }
}
