// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_intent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentIntentImpl _$$PaymentIntentImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$PaymentIntentImpl',
      json,
      ($checkedConvert) {
        final val = _$PaymentIntentImpl(
          id: $checkedConvert('id', (v) => v as String),
          clientSecret: $checkedConvert('clientSecret', (v) => v as String),
          amount: $checkedConvert('amount', (v) => (v as num).toInt()),
          currency: $checkedConvert('currency', (v) => v as String),
          status: $checkedConvert(
              'status', (v) => $enumDecode(_$PaymentStatusEnumMap, v)),
          paymentMethodId:
              $checkedConvert('paymentMethodId', (v) => v as String?),
          metadata:
              $checkedConvert('metadata', (v) => v as Map<String, dynamic>?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$PaymentIntentImplToJson(_$PaymentIntentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientSecret': instance.clientSecret,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'paymentMethodId': instance.paymentMethodId,
      'metadata': instance.metadata,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.requiresPaymentMethod: 'requires_payment_method',
  PaymentStatus.requiresConfirmation: 'requires_confirmation',
  PaymentStatus.requiresAction: 'requires_action',
  PaymentStatus.processing: 'processing',
  PaymentStatus.succeeded: 'succeeded',
  PaymentStatus.canceled: 'canceled',
  PaymentStatus.unknown: 'unknown',
};
