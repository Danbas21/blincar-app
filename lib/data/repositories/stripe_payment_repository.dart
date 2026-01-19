// lib/data/repositories/stripe_payment_repository.dart

import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../core/errors/failures.dart';
import '../../core/services/stripe_service.dart';
import '../../core/services/stripe_backend_service.dart';
import '../../core/services/service_locator.dart';
import '../../domain/entities/payment_card.dart';
import '../../domain/repositories/payment_repository.dart';

/// Implementacion del repositorio de pagos usando Stripe + Firebase
///
/// Responsabilidades:
/// - Tokenizar tarjetas con Stripe SDK
/// - Almacenar metadata en Firebase Realtime Database
/// - Vincular tarjetas al Customer en Stripe via backend
/// - Gestionar tarjetas del usuario
class StripePaymentRepository implements PaymentRepository {
  final StripeService _stripeService;
  final FirebaseDatabase _database;
  final StripeBackendService _backendService;

  /// Referencia a la coleccion de metodos de pago en Firebase
  DatabaseReference get _paymentMethodsRef => _database.ref('blincar/users');

  StripePaymentRepository({
    required StripeService stripeService,
    FirebaseDatabase? database,
    StripeBackendService? backendService,
  })  : _stripeService = stripeService,
        _database = database ?? FirebaseDatabase.instance,
        _backendService = backendService ?? getIt<StripeBackendService>();

  @override
  Future<Either<Failure, PaymentCard>> addCard({
    required String userId,
    required String cardNumber,
    required String expiryMonth,
    required String expiryYear,
    required String cvv,
    required String cardHolderName,
    required CardType cardType,
    required String lastFourDigits,
    required String stripePaymentMethodId,
    String? stripeCustomerId,
  }) async {
    try {
      final cleanCardNumber = cardNumber.replaceAll(RegExp(r'\s'), '');

      if (!CardTypeDetector.isValidCardNumber(cleanCardNumber)) {
        return const Left(
          ValidationFailure('Numero de tarjeta invalido'),
        );
      }

      if (!CardTypeDetector.isValidExpiry(expiryMonth, expiryYear)) {
        return const Left(
          ValidationFailure('Fecha de expiracion invalida'),
        );
      }

      // 1. Crear o obtener el Stripe Customer via backend
      final customerResult = await _backendService.getOrCreateCustomer();
      if (!customerResult.isSuccess) {
        return Left(PaymentFailure(
          customerResult.error ?? 'Error creando customer de Stripe',
        ));
      }

      // 2. Tokenizar con Stripe SDK (client-side)
      final paymentMethod = await _stripeService.createPaymentMethod(
        cardNumber: cardNumber,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear,
        cvv: cvv,
        cardHolderName: cardHolderName,
      );

      // 3. Vincular el PaymentMethod al Customer via backend
      final attachResult = await _backendService.attachPaymentMethod(paymentMethod.id);
      if (!attachResult.isSuccess) {
        return Left(PaymentFailure(
          attachResult.error ?? 'Error vinculando tarjeta',
        ));
      }

      // 4. Obtener datos de la tarjeta
      final lastFour = _stripeService.getLastFourDigits(paymentMethod);
      final cardBrand = _stripeService.getCardBrand(paymentMethod);

      // 5. Convertir cardBrand a CardType
      final detectedCardType = _stringToCardType(cardBrand);

      // 6. Verificar si la tarjeta ya existe en Firebase
      final existingCards = await _getCardsFromFirebase(userId);
      final isDuplicate = existingCards.any(
        (card) => card.lastFourDigits == lastFour && card.cardType == detectedCardType,
      );

      if (isDuplicate) {
        // La tarjeta ya existe localmente, pero ya se vinculo en Stripe
        // Actualizar el stripePaymentMethodId si es diferente
        return Left(PaymentFailure('Esta tarjeta ya esta registrada'));
      }

      // 7. Guardar en Firebase (cache local)
      final cardId =
          _paymentMethodsRef.child(userId).child('paymentMethods').push().key!;

      final cardData = {
        'id': cardId,
        'lastFourDigits': lastFour,
        'cardType': cardBrand, // Guardar como string en Firebase
        'cardHolderName': cardHolderName,
        'expiryMonth': expiryMonth,
        'expiryYear': expiryYear,
        'stripePaymentMethodId': paymentMethod.id,
        'isDefault': existingCards.isEmpty, // Primera tarjeta es default
        'createdAt': ServerValue.timestamp,
      };

      await _paymentMethodsRef
          .child(userId)
          .child('paymentMethods')
          .child(cardId)
          .set(cardData);

      // 8. Crear entidad PaymentCard
      final newCard = PaymentCard(
        id: cardId,
        lastFourDigits: lastFour,
        cardType: detectedCardType,
        cardHolderName: cardHolderName,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear,
        stripePaymentMethodId: paymentMethod.id,
        isDefault: existingCards.isEmpty,
      );

      return Right(newCard);
    } on StripeException catch (e) {
      return Left(PaymentFailure(
        e.error.localizedMessage ?? 'Error al procesar la tarjeta',
      ));
    } catch (e) {
      return Left(ServerFailure('Error al agregar tarjeta: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<PaymentCard>>> getCards(String userId) async {
    try {
      final cards = await _getCardsFromFirebase(userId);
      return Right(cards);
    } catch (e) {
      return Left(ServerFailure('Error al cargar tarjetas: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCard({
    required String userId,
    required String cardId,
  }) async {
    try {
      // Verificar si la tarjeta a eliminar es la default
      final snapshot = await _paymentMethodsRef
          .child(userId)
          .child('paymentMethods')
          .child(cardId)
          .get();

      if (!snapshot.exists) {
        return Left(PaymentFailure('Tarjeta no encontrada'));
      }

      final cardData = snapshot.value as Map<dynamic, dynamic>;
      final wasDefault = cardData['isDefault'] == true;

      // Eliminar tarjeta
      await _paymentMethodsRef
          .child(userId)
          .child('paymentMethods')
          .child(cardId)
          .remove();

      // Si era default, asignar otra como default
      if (wasDefault) {
        final remainingCards = await _getCardsFromFirebase(userId);
        if (remainingCards.isNotEmpty) {
          await _paymentMethodsRef
              .child(userId)
              .child('paymentMethods')
              .child(remainingCards.first.id)
              .update({'isDefault': true});
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Error al eliminar tarjeta: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> setDefaultCard({
    required String userId,
    required String cardId,
  }) async {
    try {
      // Obtener todas las tarjetas
      final cards = await _getCardsFromFirebase(userId);

      // Actualizar todas las tarjetas
      for (final card in cards) {
        await _paymentMethodsRef
            .child(userId)
            .child('paymentMethods')
            .child(card.id)
            .update({'isDefault': card.id == cardId});
      }

      return const Right(null);
    } catch (e) {
      return Left(
          ServerFailure('Error al actualizar tarjeta: ${e.toString()}'));
    }
  }

  /// Obtiene las tarjetas del usuario desde Firebase
  Future<List<PaymentCard>> _getCardsFromFirebase(String userId) async {
    final snapshot =
        await _paymentMethodsRef.child(userId).child('paymentMethods').get();

    if (!snapshot.exists || snapshot.value == null) {
      return [];
    }

    final cardsMap = snapshot.value as Map<dynamic, dynamic>;
    final cards = <PaymentCard>[];

    cardsMap.forEach((key, value) {
      final cardData = value as Map<dynamic, dynamic>;
      final cardTypeStr = cardData['cardType'] as String? ?? 'unknown';
      cards.add(PaymentCard(
        id: cardData['id'] as String? ?? key as String,
        lastFourDigits: cardData['lastFourDigits'] as String? ?? '****',
        cardType: _stringToCardType(cardTypeStr),
        cardHolderName: cardData['cardHolderName'] as String? ?? '',
        expiryMonth: cardData['expiryMonth'] as String? ?? '',
        expiryYear: cardData['expiryYear'] as String? ?? '',
        stripePaymentMethodId:
            cardData['stripePaymentMethodId'] as String? ?? '',
        isDefault: cardData['isDefault'] as bool? ?? false,
      ));
    });

    // Ordenar: default primero
    cards.sort((a, b) {
      if (a.isDefault && !b.isDefault) return -1;
      if (!a.isDefault && b.isDefault) return 1;
      return 0;
    });

    return cards;
  }

  /// Convierte un string a CardType
  CardType _stringToCardType(String brand) {
    switch (brand.toLowerCase()) {
      case 'visa':
        return CardType.visa;
      case 'mastercard':
        return CardType.mastercard;
      case 'amex':
      case 'american express':
        return CardType.amex;
      case 'carnet':
        return CardType.carnet;
      default:
        return CardType.unknown;
    }
  }
}
