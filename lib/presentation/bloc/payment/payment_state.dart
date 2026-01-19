// lib/presentation/bloc/payment/payment_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/payment_card.dart';

part 'payment_state.freezed.dart';

/// Estados del PaymentBloc
///
/// Usa sealed class pattern con Freezed para type-safety
/// y pattern matching exhaustivo.
@Freezed(toJson: false, fromJson: false)
sealed class PaymentState with _$PaymentState {
  /// Estado inicial
  const factory PaymentState.initial() = PaymentInitial;

  /// Cargando tarjetas o procesando operacion
  const factory PaymentState.loading() = PaymentLoading;

  /// Tarjetas cargadas exitosamente
  const factory PaymentState.loaded(List<PaymentCard> cards) = PaymentLoaded;

  /// Tarjeta agregada exitosamente
  const factory PaymentState.cardAdded({
    required PaymentCard card,
    required List<PaymentCard> cards,
    required String message,
  }) = CardAdded;

  /// Tarjeta eliminada exitosamente
  const factory PaymentState.cardDeleted({
    required List<PaymentCard> cards,
    required String message,
  }) = CardDeleted;

  /// Tarjeta predeterminada actualizada
  const factory PaymentState.defaultCardUpdated({
    required List<PaymentCard> cards,
    required String message,
  }) = DefaultCardUpdated;

  /// Error en operacion de pago
  const factory PaymentState.error({
    required String message,
    List<PaymentCard>? cards,
  }) = PaymentError;
}
