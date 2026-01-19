// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentCardImpl _$$PaymentCardImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$PaymentCardImpl',
      json,
      ($checkedConvert) {
        final val = _$PaymentCardImpl(
          id: $checkedConvert('id', (v) => v as String),
          lastFourDigits: $checkedConvert('lastFourDigits', (v) => v as String),
          cardType: $checkedConvert(
              'cardType', (v) => $enumDecode(_$CardTypeEnumMap, v)),
          cardHolderName: $checkedConvert('cardHolderName', (v) => v as String),
          expiryMonth: $checkedConvert('expiryMonth', (v) => v as String),
          expiryYear: $checkedConvert('expiryYear', (v) => v as String),
          stripeCustomerId:
              $checkedConvert('stripeCustomerId', (v) => v as String?),
          isDefault: $checkedConvert('isDefault', (v) => v as bool? ?? false),
          stripePaymentMethodId:
              $checkedConvert('stripePaymentMethodId', (v) => v as String?),
          createdAt: $checkedConvert('createdAt',
              (v) => v == null ? null : DateTime.parse(v as String)),
          userId: $checkedConvert('userId', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$PaymentCardImplToJson(_$PaymentCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lastFourDigits': instance.lastFourDigits,
      'cardType': _$CardTypeEnumMap[instance.cardType]!,
      'cardHolderName': instance.cardHolderName,
      'expiryMonth': instance.expiryMonth,
      'expiryYear': instance.expiryYear,
      'stripeCustomerId': instance.stripeCustomerId,
      'isDefault': instance.isDefault,
      'stripePaymentMethodId': instance.stripePaymentMethodId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'userId': instance.userId,
    };

const _$CardTypeEnumMap = {
  CardType.visa: 'visa',
  CardType.mastercard: 'mastercard',
  CardType.carnet: 'carnet',
  CardType.amex: 'amex',
  CardType.unknown: 'unknown',
};
