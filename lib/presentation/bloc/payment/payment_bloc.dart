// lib/presentation/bloc/payment/payment_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/payment_card.dart';
import '../../../domain/repositories/payment_repository.dart';
import 'payment_event.dart';
import 'payment_state.dart';

/// BLoC para manejar metodos de pago
///
/// Responsabilidades:
/// - Cargar tarjetas del usuario
/// - Agregar nuevas tarjetas (tokenizacion con Stripe)
/// - Eliminar tarjetas
/// - Establecer tarjeta predeterminada
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository _paymentRepository;

  PaymentBloc({
    required PaymentRepository paymentRepository,
  })  : _paymentRepository = paymentRepository,
        super(const PaymentInitial()) {
    on<LoadCardsEvent>(_onLoadCards);
    on<AddCardEvent>(_onAddCard);
    on<DeleteCardEvent>(_onDeleteCard);
    on<SetDefaultCardEvent>(_onSetDefaultCard);
  }

  /// Carga las tarjetas del usuario
  Future<void> _onLoadCards(
    LoadCardsEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentLoading());

    final result = await _paymentRepository.getCards(event.userId);

    result.fold(
      (failure) => emit(PaymentError(message: failure.message)),
      (cards) => emit(PaymentLoaded(cards)),
    );
  }

  /// Agrega una nueva tarjeta
  Future<void> _onAddCard(
    AddCardEvent event,
    Emitter<PaymentState> emit,
  ) async {
    // Guardar las tarjetas actuales para restaurarlas en caso de error
    final currentCards = _getCurrentCards();

    emit(const PaymentLoading());

    final result = await _paymentRepository.addCard(
      userId: event.userId,
      cardNumber: event.cardNumber,
      expiryMonth: event.expiryMonth,
      expiryYear: event.expiryYear,
      cvv: event.cvv,
      cardHolderName: event.cardHolderName,
      stripePaymentMethodId: '',
      lastFourDigits: '',
      cardType: CardType.unknown,
    );

    await result.fold(
      (failure) async {
        emit(PaymentError(
          message: failure.message,
          cards: currentCards,
        ));
      },
      (newCard) async {
        // Recargar las tarjetas para obtener la lista actualizada
        final cardsResult = await _paymentRepository.getCards(event.userId);
        cardsResult.fold(
          (failure) => emit(PaymentError(message: failure.message)),
          (cards) => emit(CardAdded(
            card: newCard,
            cards: cards,
            message: 'Tarjeta agregada correctamente',
          )),
        );
      },
    );
  }

  /// Elimina una tarjeta
  Future<void> _onDeleteCard(
    DeleteCardEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final currentCards = _getCurrentCards();

    emit(const PaymentLoading());

    final result = await _paymentRepository.deleteCard(
      userId: event.userId,
      cardId: event.cardId,
    );

    await result.fold(
      (failure) async {
        emit(PaymentError(
          message: failure.message,
          cards: currentCards,
        ));
      },
      (_) async {
        // Recargar las tarjetas para obtener la lista actualizada
        final cardsResult = await _paymentRepository.getCards(event.userId);
        cardsResult.fold(
          (failure) => emit(PaymentError(message: failure.message)),
          (cards) => emit(CardDeleted(
            cards: cards,
            message: 'Tarjeta eliminada correctamente',
          )),
        );
      },
    );
  }

  /// Establece una tarjeta como predeterminada
  Future<void> _onSetDefaultCard(
    SetDefaultCardEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final currentCards = _getCurrentCards();

    emit(const PaymentLoading());

    final result = await _paymentRepository.setDefaultCard(
      userId: event.userId,
      cardId: event.cardId,
    );

    await result.fold(
      (failure) async {
        emit(PaymentError(
          message: failure.message,
          cards: currentCards,
        ));
      },
      (_) async {
        // Recargar las tarjetas para obtener la lista actualizada
        final cardsResult = await _paymentRepository.getCards(event.userId);
        cardsResult.fold(
          (failure) => emit(PaymentError(message: failure.message)),
          (cards) => emit(DefaultCardUpdated(
            cards: cards,
            message: 'Tarjeta predeterminada actualizada',
          )),
        );
      },
    );
  }

  /// Obtiene las tarjetas actuales del estado
  List<PaymentCard> _getCurrentCards() {
    return switch (state) {
      PaymentLoaded(cards: final cards) => cards,
      CardAdded(cards: final cards) => cards,
      CardDeleted(cards: final cards) => cards,
      DefaultCardUpdated(cards: final cards) => cards,
      PaymentError(cards: final cards) => cards ?? [],
      _ => [],
    };
  }
}
