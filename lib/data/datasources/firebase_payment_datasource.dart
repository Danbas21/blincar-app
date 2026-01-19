// lib/data/datasources/firebase_payment_datasource.dart

import 'package:firebase_database/firebase_database.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/payment_card.dart';

/// DataSource para operaciones de pago en Firebase Realtime Database
abstract class FirebasePaymentDataSource {
  /// Obtiene las tarjetas del usuario
  Future<List<PaymentCard>> getCards(String userId);

  /// Guarda una tarjeta en Firebase
  Future<PaymentCard> saveCard({
    required String userId,
    required String stripePaymentMethodId,
    required String lastFourDigits,
    required CardType cardType,
    required String expiryMonth,
    required String expiryYear,
    required String cardHolderName,
    String? stripeCustomerId,
  });

  /// Elimina una tarjeta
  Future<void> deleteCard(String userId, String cardId);

  /// Establece una tarjeta como predeterminada
  Future<void> setDefaultCard(String userId, String cardId);
}

class FirebasePaymentDataSourceImpl implements FirebasePaymentDataSource {
  final FirebaseDatabase database;

  const FirebasePaymentDataSourceImpl({required this.database});

  DatabaseReference _paymentMethodsRef(String userId) =>
      database.ref('blincar/users/$userId/paymentMethods');

  @override
  Future<List<PaymentCard>> getCards(String userId) async {
    try {
      final snapshot = await _paymentMethodsRef(userId).get();

      if (!snapshot.exists || snapshot.value == null) {
        return [];
      }

      final cardsMap = snapshot.value as Map<dynamic, dynamic>;
      final cards = <PaymentCard>[];

      cardsMap.forEach((key, value) {
        final cardData = value as Map<dynamic, dynamic>;
        cards.add(_mapToPaymentCard(key as String, cardData));
      });

      // Ordenar: default primero
      cards.sort((a, b) {
        if (a.isDefault && !b.isDefault) return -1;
        if (!a.isDefault && b.isDefault) return 1;
        return 0;
      });

      return cards;
    } catch (e) {
      throw ServerFailure('Error al cargar tarjetas: ${e.toString()}');
    }
  }

  @override
  Future<PaymentCard> saveCard({
    required String userId,
    required String stripePaymentMethodId,
    required String lastFourDigits,
    required CardType cardType,
    required String expiryMonth,
    required String expiryYear,
    required String cardHolderName,
    String? stripeCustomerId,
  }) async {
    try {
      // Verificar si es la primera tarjeta
      final existingCards = await getCards(userId);
      final isFirstCard = existingCards.isEmpty;

      // Generar ID único
      final cardRef = _paymentMethodsRef(userId).push();
      final cardId = cardRef.key!;

      final cardData = {
        'id': cardId,
        'lastFourDigits': lastFourDigits,
        'cardType': cardType.name,
        'cardHolderName': cardHolderName,
        'expiryMonth': expiryMonth,
        'expiryYear': expiryYear,
        'stripePaymentMethodId': stripePaymentMethodId,
        'stripeCustomerId': stripeCustomerId,
        'userId': userId,
        'isDefault': isFirstCard,
        'createdAt': ServerValue.timestamp,
      };

      await cardRef.set(cardData);

      return PaymentCard(
        id: cardId,
        lastFourDigits: lastFourDigits,
        cardType: cardType,
        cardHolderName: cardHolderName,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear,
        stripePaymentMethodId: stripePaymentMethodId,
        stripeCustomerId: stripeCustomerId,
        userId: userId,
        isDefault: isFirstCard,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw ServerFailure('Error al guardar la tarjeta: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteCard(String userId, String cardId) async {
    try {
      final cardRef = _paymentMethodsRef(userId).child(cardId);
      final snapshot = await cardRef.get();

      if (!snapshot.exists) {
        throw const NotFoundFailure('Tarjeta no encontrada');
      }

      final cardData = snapshot.value as Map<dynamic, dynamic>;
      final wasDefault = cardData['isDefault'] as bool? ?? false;

      // Eliminar tarjeta
      await cardRef.remove();

      // Si era default, establecer otra
      if (wasDefault) {
        final remainingCards = await getCards(userId);
        if (remainingCards.isNotEmpty) {
          await setDefaultCard(userId, remainingCards.first.id);
        }
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure('Error al eliminar la tarjeta: ${e.toString()}');
    }
  }

  @override
  Future<void> setDefaultCard(String userId, String cardId) async {
    try {
      // Obtener todas las tarjetas
      final cards = await getCards(userId);

      // Actualizar en batch
      final updates = <String, dynamic>{};
      for (final card in cards) {
        updates['${card.id}/isDefault'] = card.id == cardId;
      }

      await _paymentMethodsRef(userId).update(updates);
    } catch (e) {
      throw ServerFailure(
        'Error al actualizar la tarjeta predeterminada: ${e.toString()}',
      );
    }
  }

  /// Mapea datos de Firebase a PaymentCard
  PaymentCard _mapToPaymentCard(String id, Map<dynamic, dynamic> data) {
    return PaymentCard(
      id: id,
      lastFourDigits: data['lastFourDigits'] as String? ?? '****',
      cardType: _parseCardType(data['cardType'] as String? ?? 'unknown'),
      cardHolderName: data['cardHolderName'] as String? ?? '',
      expiryMonth: data['expiryMonth'] as String? ?? '',
      expiryYear: data['expiryYear'] as String? ?? '',
      stripePaymentMethodId: data['stripePaymentMethodId'] as String?,
      stripeCustomerId: data['stripeCustomerId'] as String?,
      userId: data['userId'] as String?,
      isDefault: data['isDefault'] as bool? ?? false,
      createdAt: data['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['createdAt'] as int)
          : null,
    );
  }

  CardType _parseCardType(String type) {
    return switch (type) {
      'visa' => CardType.visa,
      'mastercard' => CardType.mastercard,
      'carnet' => CardType.carnet,
      'amex' => CardType.amex,
      _ => CardType.unknown,
    };
  }
}
