// lib/presentation/bloc/payment/payment_event.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_event.freezed.dart';

/// Eventos del PaymentBloc
///
/// Usa sealed class pattern con Freezed para type-safety
/// y pattern matching exhaustivo.
@Freezed(toJson: false, fromJson: false)
sealed class PaymentEvent with _$PaymentEvent {
  /// Evento para cargar las tarjetas del usuario
  const factory PaymentEvent.loadCards({
    required String userId,
  }) = LoadCardsEvent;

  /// Evento para agregar una nueva tarjeta
  const factory PaymentEvent.addCard({
    required String userId,
    required String cardNumber,
    required String expiryMonth,
    required String expiryYear,
    required String cvv,
    required String cardHolderName,
  }) = AddCardEvent;

  /// Evento para eliminar una tarjeta
  const factory PaymentEvent.deleteCard({
    required String userId,
    required String cardId,
  }) = DeleteCardEvent;

  /// Evento para establecer una tarjeta como predeterminada
  const factory PaymentEvent.setDefaultCard({
    required String userId,
    required String cardId,
  }) = SetDefaultCardEvent;
}
