// lib/core/services/stripe_service.dart

import 'package:flutter_stripe/flutter_stripe.dart';
import '../constants/stripe_constants.dart';

/// Servicio para manejar la integracion con Stripe
///
/// Responsabilidades:
/// - Inicializar el SDK de Stripe
/// - Crear PaymentMethods a partir de datos de tarjeta
/// - Manejar errores de Stripe
class StripeService {
  static bool _isInitialized = false;

  /// Inicializa el SDK de Stripe
  ///
  /// Debe llamarse en main() antes de runApp()
  static Future<void> initialize() async {
    if (_isInitialized) return;

    Stripe.publishableKey = StripeConstants.publishableKey;
    Stripe.merchantIdentifier = StripeConstants.merchantId;

    await Stripe.instance.applySettings();
    _isInitialized = true;
  }

  /// Crea un PaymentMethod a partir de los datos de la tarjeta
  ///
  /// Los datos de la tarjeta se tokenizan de forma segura por Stripe
  /// y nunca tocan nuestro servidor.
  ///
  /// Retorna el PaymentMethod ID si es exitoso.
  Future<PaymentMethod> createPaymentMethod({
    required String cardNumber,
    required String expiryMonth,
    required String expiryYear,
    required String cvv,
    required String cardHolderName,
  }) async {
    // Crear los detalles de la tarjeta
    final cardDetails = CardDetails(
      number: cardNumber.replaceAll(' ', ''),
      expirationMonth: int.parse(expiryMonth),
      expirationYear: int.parse('20$expiryYear'),
      cvc: cvv,
    );

    // Actualizar los detalles de la tarjeta en el SDK
    await Stripe.instance.dangerouslyUpdateCardDetails(cardDetails);

    // Crear el PaymentMethod
    final paymentMethod = await Stripe.instance.createPaymentMethod(
      params: PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(
          billingDetails: BillingDetails(
            name: cardHolderName,
          ),
        ),
      ),
    );

    return paymentMethod;
  }

  /// Obtiene el tipo de tarjeta del PaymentMethod
  String getCardBrand(PaymentMethod paymentMethod) {
    return paymentMethod.card.brand ?? 'unknown';
  }

  /// Obtiene los ultimos 4 digitos de la tarjeta
  String getLastFourDigits(PaymentMethod paymentMethod) {
    return paymentMethod.card.last4 ?? '****';
  }
}
