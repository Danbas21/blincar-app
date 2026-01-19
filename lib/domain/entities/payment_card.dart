// lib/domain/entities/payment_card.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_card.freezed.dart';
part 'payment_card.g.dart';

/// Tipos de tarjeta soportados
enum CardType {
  visa,
  mastercard,
  carnet,
  amex,
  unknown,
}

/// Entidad PaymentCard
///
/// Representa una tarjeta de pago del usuario.
/// Solo se almacenan los últimos 4 dígitos por seguridad.
@freezed
class PaymentCard with _$PaymentCard {
  const PaymentCard._();

  const factory PaymentCard({
    required String id,
    required String lastFourDigits,
    required CardType cardType,
    required String cardHolderName,
    required String expiryMonth,
    required String expiryYear,
    String? stripeCustomerId,
    @Default(false) bool isDefault,
    String? stripePaymentMethodId,
    DateTime? createdAt,
    String? userId,
  }) = _PaymentCard;

  factory PaymentCard.fromJson(Map<String, dynamic> json) =>
      _$PaymentCardFromJson(json);

  /// Obtiene el nombre del tipo de tarjeta
  String get cardTypeName {
    switch (cardType) {
      case CardType.visa:
        return 'Visa';
      case CardType.mastercard:
        return 'Mastercard';
      case CardType.carnet:
        return 'Carnet';
      case CardType.amex:
        return 'American Express';
      case CardType.unknown:
        return 'Tarjeta';
    }
  }

  /// Obtiene el texto de expiración formateado
  String get expiryDate => '$expiryMonth/$expiryYear';

  /// Obtiene el número enmascarado de la tarjeta
  String get maskedNumber => '**** **** **** $lastFourDigits';
}

/// Utilidad para detectar el tipo de tarjeta basado en el número
class CardTypeDetector {
  /// Detecta el tipo de tarjeta basado en los primeros dígitos
  static CardType detectCardType(String cardNumber) {
    // Remover espacios y guiones
    final cleanNumber = cardNumber.replaceAll(RegExp(r'[\s-]'), '');

    if (cleanNumber.isEmpty) {
      return CardType.unknown;
    }

    // Visa: Comienza con 4
    if (cleanNumber.startsWith('4')) {
      return CardType.visa;
    }

    // Mastercard: Comienza con 51-55 o 2221-2720
    if (cleanNumber.length >= 2) {
      final firstTwo = int.tryParse(cleanNumber.substring(0, 2)) ?? 0;
      if (firstTwo >= 51 && firstTwo <= 55) {
        return CardType.mastercard;
      }

      if (cleanNumber.length >= 4) {
        final firstFour = int.tryParse(cleanNumber.substring(0, 4)) ?? 0;
        if (firstFour >= 2221 && firstFour <= 2720) {
          return CardType.mastercard;
        }
      }
    }

    // American Express: Comienza con 34 o 37
    if (cleanNumber.length >= 2) {
      final firstTwo = cleanNumber.substring(0, 2);
      if (firstTwo == '34' || firstTwo == '37') {
        return CardType.amex;
      }
    }

    // Carnet: BINs mexicanos específicos
    // Carnet usa varios rangos de BIN, aquí incluimos algunos comunes
    if (cleanNumber.length >= 6) {
      final bin = cleanNumber.substring(0, 6);
      final binInt = int.tryParse(bin) ?? 0;

      // Rangos de BIN de Carnet (ejemplos - se pueden agregar más)
      // 506199-506499
      if (binInt >= 506199 && binInt <= 506499) {
        return CardType.carnet;
      }
      // 627535
      if (bin.startsWith('627535')) {
        return CardType.carnet;
      }
      // 639485-639489
      if (binInt >= 639485 && binInt <= 639489) {
        return CardType.carnet;
      }
    }

    return CardType.unknown;
  }

  /// Valida el número de tarjeta usando el algoritmo de Luhn
  static bool isValidCardNumber(String cardNumber) {
    final cleanNumber = cardNumber.replaceAll(RegExp(r'[\s-]'), '');

    if (cleanNumber.isEmpty || cleanNumber.length < 13) {
      return false;
    }

    // Verificar que solo contenga dígitos
    if (!RegExp(r'^\d+$').hasMatch(cleanNumber)) {
      return false;
    }

    // Algoritmo de Luhn
    int sum = 0;
    bool alternate = false;

    for (int i = cleanNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cleanNumber[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  /// Valida la fecha de expiración
  static bool isValidExpiry(String month, String year) {
    final monthInt = int.tryParse(month);
    final yearInt = int.tryParse(year);

    if (monthInt == null || yearInt == null) {
      return false;
    }

    if (monthInt < 1 || monthInt > 12) {
      return false;
    }

    final now = DateTime.now();
    final currentYear = now.year % 100; // Obtener últimos 2 dígitos
    final currentMonth = now.month;

    // Si el año es menor al actual, está expirada
    if (yearInt < currentYear) {
      return false;
    }

    // Si es el mismo año, verificar el mes
    if (yearInt == currentYear && monthInt < currentMonth) {
      return false;
    }

    return true;
  }

  /// Valida el CVV
  static bool isValidCVV(String cvv, CardType cardType) {
    final cleanCVV = cvv.replaceAll(RegExp(r'\s'), '');

    // AMEX tiene 4 dígitos, las demás 3
    final expectedLength = cardType == CardType.amex ? 4 : 3;

    return RegExp(r'^\d+$').hasMatch(cleanCVV) &&
        cleanCVV.length == expectedLength;
  }

  /// Formatea el número de tarjeta con espacios
  static String formatCardNumber(String cardNumber) {
    final cleanNumber = cardNumber.replaceAll(RegExp(r'[\s-]'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < cleanNumber.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(cleanNumber[i]);
    }

    return buffer.toString();
  }
}
