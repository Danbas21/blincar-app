// lib/data/models/payment_card_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/payment_card.dart';

/// Extension de PaymentCard para serializacion de Firebase
extension PaymentCardModel on PaymentCard {
  /// Convierte desde Firestore Document
  static PaymentCard fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return PaymentCard(
      id: doc.id,
      lastFourDigits: data['lastFourDigits'] as String,
      cardType: _parseCardType(data['cardType'] as String),
      cardHolderName: data['cardHolderName'] as String,
      expiryMonth: data['expiryMonth'] as String,
      expiryYear: data['expiryYear'] as String,
      isDefault: data['isDefault'] as bool? ?? false,
      stripePaymentMethodId: data['stripePaymentMethodId'] as String?,
      stripeCustomerId: data['stripeCustomerId'] as String?,
      userId: data['userId'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Convierte a Map para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'lastFourDigits': lastFourDigits,
      'cardType': cardType.name,
      'cardHolderName': cardHolderName,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'isDefault': isDefault,
      'stripePaymentMethodId': stripePaymentMethodId,
      'stripeCustomerId': stripeCustomerId,
      'userId': userId,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
    };
  }

  static CardType _parseCardType(String type) {
    return switch (type) {
      'visa' => CardType.visa,
      'mastercard' => CardType.mastercard,
      'carnet' => CardType.carnet,
      'amex' => CardType.amex,
      _ => CardType.unknown,
    };
  }
}
