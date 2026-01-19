// lib/domain/entities/payment_intent.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_intent.freezed.dart';
part 'payment_intent.g.dart';

/// Estados del payment intent
enum PaymentStatus {
  @JsonValue('requires_payment_method')
  requiresPaymentMethod,
  @JsonValue('requires_confirmation')
  requiresConfirmation,
  @JsonValue('requires_action')
  requiresAction,
  @JsonValue('processing')
  processing,
  @JsonValue('succeeded')
  succeeded,
  @JsonValue('canceled')
  canceled,
  @JsonValue('unknown')
  unknown;
}

/// Entidad de dominio para Payment Intent de Stripe
@freezed
class PaymentIntent with _$PaymentIntent {
  const PaymentIntent._();

  const factory PaymentIntent({
    required String id,
    required String clientSecret,
    required int amount, // En centavos
    required String currency,
    required PaymentStatus status,
    String? paymentMethodId,
    Map<String, dynamic>? metadata,
  }) = _PaymentIntent;

  factory PaymentIntent.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentFromJson(json);

  /// Monto formateado para mostrar
  String get formattedAmount {
    final dollars = amount / 100;
    return '\$${dollars.toStringAsFixed(2)}';
  }

  /// Verifica si el pago fue exitoso
  bool get isSucceeded => status == PaymentStatus.succeeded;

  /// Verifica si el pago esta en proceso
  bool get isProcessing => status == PaymentStatus.processing;

  /// Verifica si requiere accion del usuario
  bool get requiresAction => status == PaymentStatus.requiresAction;
}
