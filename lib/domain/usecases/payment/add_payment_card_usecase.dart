// lib/domain/usecases/payment/add_payment_card_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/payment_card.dart';
import '../../repositories/payment_repository.dart';

/// Caso de uso para agregar una tarjeta de pago
///
/// Tokeniza la tarjeta con Stripe y la guarda en Firebase.
class AddPaymentCardUseCase extends UseCase<PaymentCard, AddCardParams> {
  final PaymentRepository _repository;

  AddPaymentCardUseCase(this._repository);

  @override
  Future<Either<Failure, PaymentCard>> call(AddCardParams params) {
    return _repository.addCard(
      userId: params.userId,
      cardNumber: params.cardNumber,
      expiryMonth: params.expiryMonth,
      expiryYear: params.expiryYear,
      cvv: params.cvv,
      cardHolderName: params.cardHolderName,
      stripePaymentMethodId: '',
      lastFourDigits: '',
      cardType: CardType.unknown,
    );
  }
}

/// Parametros para agregar una tarjeta
class AddCardParams extends Equatable {
  final String userId;
  final String cardNumber;
  final String expiryMonth;
  final String expiryYear;
  final String cvv;
  final String cardHolderName;

  const AddCardParams({
    required this.userId,
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvv,
    required this.cardHolderName,
  });

  @override
  List<Object?> get props => [
        userId,
        cardNumber,
        expiryMonth,
        expiryYear,
        cvv,
        cardHolderName,
      ];
}
