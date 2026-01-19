// lib/domain/repositories/payment_repository.dart

import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/payment_card.dart';

/// Repositorio abstracto para operaciones de pago
///
/// Define el contrato para manejar tarjetas de pago del usuario.
/// La implementacion concreta usa Stripe para tokenizacion
/// y Firebase para persistencia.
abstract class PaymentRepository {
  /// Agrega una nueva tarjeta de pago
  ///
  /// Tokeniza la tarjeta con Stripe y guarda los datos en Firebase.
  /// Solo se almacenan: ultimos 4 digitos, tipo, nombre, stripePaymentMethodId.
  ///
  /// [userId] ID del usuario propietario
  /// [cardNumber] Numero completo de la tarjeta
  /// [expiryMonth] Mes de expiracion (01-12)
  /// [expiryYear] Ano de expiracion (YY)
  /// [cvv] Codigo de seguridad
  /// [cardHolderName] Nombre del titular
  Future<Either<Failure, PaymentCard>> addCard({
    required String userId,
    required String stripePaymentMethodId,
    required String lastFourDigits,
    required CardType cardType,
    required String expiryMonth,
    required String expiryYear,
    required String cardHolderName,
    String? stripeCustomerId,
    required String cardNumber,
    required String cvv,
  });

  /// Obtiene todas las tarjetas del usuario
  ///
  /// [userId] ID del usuario
  Future<Either<Failure, List<PaymentCard>>> getCards(String userId);

  /// Elimina una tarjeta del usuario
  ///
  /// [userId] ID del usuario
  /// [cardId] ID de la tarjeta a eliminar
  Future<Either<Failure, void>> deleteCard({
    required String userId,
    required String cardId,
  });

  /// Establece una tarjeta como predeterminada
  ///
  /// [userId] ID del usuario
  /// [cardId] ID de la tarjeta a establecer como predeterminada
  Future<Either<Failure, void>> setDefaultCard({
    required String userId,
    required String cardId,
  });
}
