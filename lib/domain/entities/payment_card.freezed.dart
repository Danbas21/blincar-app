// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaymentCard _$PaymentCardFromJson(Map<String, dynamic> json) {
  return _PaymentCard.fromJson(json);
}

/// @nodoc
mixin _$PaymentCard {
  String get id => throw _privateConstructorUsedError;
  String get lastFourDigits => throw _privateConstructorUsedError;
  CardType get cardType => throw _privateConstructorUsedError;
  String get cardHolderName => throw _privateConstructorUsedError;
  String get expiryMonth => throw _privateConstructorUsedError;
  String get expiryYear => throw _privateConstructorUsedError;
  String? get stripeCustomerId => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  String? get stripePaymentMethodId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String lastFourDigits,
            CardType cardType,
            String cardHolderName,
            String expiryMonth,
            String expiryYear,
            String? stripeCustomerId,
            bool isDefault,
            String? stripePaymentMethodId,
            DateTime? createdAt,
            String? userId)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String lastFourDigits,
            CardType cardType,
            String cardHolderName,
            String expiryMonth,
            String expiryYear,
            String? stripeCustomerId,
            bool isDefault,
            String? stripePaymentMethodId,
            DateTime? createdAt,
            String? userId)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String lastFourDigits,
            CardType cardType,
            String cardHolderName,
            String expiryMonth,
            String expiryYear,
            String? stripeCustomerId,
            bool isDefault,
            String? stripePaymentMethodId,
            DateTime? createdAt,
            String? userId)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PaymentCard value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PaymentCard value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PaymentCard value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this PaymentCard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentCardCopyWith<PaymentCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCardCopyWith<$Res> {
  factory $PaymentCardCopyWith(
          PaymentCard value, $Res Function(PaymentCard) then) =
      _$PaymentCardCopyWithImpl<$Res, PaymentCard>;
  @useResult
  $Res call(
      {String id,
      String lastFourDigits,
      CardType cardType,
      String cardHolderName,
      String expiryMonth,
      String expiryYear,
      String? stripeCustomerId,
      bool isDefault,
      String? stripePaymentMethodId,
      DateTime? createdAt,
      String? userId});
}

/// @nodoc
class _$PaymentCardCopyWithImpl<$Res, $Val extends PaymentCard>
    implements $PaymentCardCopyWith<$Res> {
  _$PaymentCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastFourDigits = null,
    Object? cardType = null,
    Object? cardHolderName = null,
    Object? expiryMonth = null,
    Object? expiryYear = null,
    Object? stripeCustomerId = freezed,
    Object? isDefault = null,
    Object? stripePaymentMethodId = freezed,
    Object? createdAt = freezed,
    Object? userId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lastFourDigits: null == lastFourDigits
          ? _value.lastFourDigits
          : lastFourDigits // ignore: cast_nullable_to_non_nullable
              as String,
      cardType: null == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as CardType,
      cardHolderName: null == cardHolderName
          ? _value.cardHolderName
          : cardHolderName // ignore: cast_nullable_to_non_nullable
              as String,
      expiryMonth: null == expiryMonth
          ? _value.expiryMonth
          : expiryMonth // ignore: cast_nullable_to_non_nullable
              as String,
      expiryYear: null == expiryYear
          ? _value.expiryYear
          : expiryYear // ignore: cast_nullable_to_non_nullable
              as String,
      stripeCustomerId: freezed == stripeCustomerId
          ? _value.stripeCustomerId
          : stripeCustomerId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      stripePaymentMethodId: freezed == stripePaymentMethodId
          ? _value.stripePaymentMethodId
          : stripePaymentMethodId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentCardImplCopyWith<$Res>
    implements $PaymentCardCopyWith<$Res> {
  factory _$$PaymentCardImplCopyWith(
          _$PaymentCardImpl value, $Res Function(_$PaymentCardImpl) then) =
      __$$PaymentCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String lastFourDigits,
      CardType cardType,
      String cardHolderName,
      String expiryMonth,
      String expiryYear,
      String? stripeCustomerId,
      bool isDefault,
      String? stripePaymentMethodId,
      DateTime? createdAt,
      String? userId});
}

/// @nodoc
class __$$PaymentCardImplCopyWithImpl<$Res>
    extends _$PaymentCardCopyWithImpl<$Res, _$PaymentCardImpl>
    implements _$$PaymentCardImplCopyWith<$Res> {
  __$$PaymentCardImplCopyWithImpl(
      _$PaymentCardImpl _value, $Res Function(_$PaymentCardImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastFourDigits = null,
    Object? cardType = null,
    Object? cardHolderName = null,
    Object? expiryMonth = null,
    Object? expiryYear = null,
    Object? stripeCustomerId = freezed,
    Object? isDefault = null,
    Object? stripePaymentMethodId = freezed,
    Object? createdAt = freezed,
    Object? userId = freezed,
  }) {
    return _then(_$PaymentCardImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lastFourDigits: null == lastFourDigits
          ? _value.lastFourDigits
          : lastFourDigits // ignore: cast_nullable_to_non_nullable
              as String,
      cardType: null == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as CardType,
      cardHolderName: null == cardHolderName
          ? _value.cardHolderName
          : cardHolderName // ignore: cast_nullable_to_non_nullable
              as String,
      expiryMonth: null == expiryMonth
          ? _value.expiryMonth
          : expiryMonth // ignore: cast_nullable_to_non_nullable
              as String,
      expiryYear: null == expiryYear
          ? _value.expiryYear
          : expiryYear // ignore: cast_nullable_to_non_nullable
              as String,
      stripeCustomerId: freezed == stripeCustomerId
          ? _value.stripeCustomerId
          : stripeCustomerId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      stripePaymentMethodId: freezed == stripePaymentMethodId
          ? _value.stripePaymentMethodId
          : stripePaymentMethodId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentCardImpl extends _PaymentCard {
  const _$PaymentCardImpl(
      {required this.id,
      required this.lastFourDigits,
      required this.cardType,
      required this.cardHolderName,
      required this.expiryMonth,
      required this.expiryYear,
      this.stripeCustomerId,
      this.isDefault = false,
      this.stripePaymentMethodId,
      this.createdAt,
      this.userId})
      : super._();

  factory _$PaymentCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentCardImplFromJson(json);

  @override
  final String id;
  @override
  final String lastFourDigits;
  @override
  final CardType cardType;
  @override
  final String cardHolderName;
  @override
  final String expiryMonth;
  @override
  final String expiryYear;
  @override
  final String? stripeCustomerId;
  @override
  @JsonKey()
  final bool isDefault;
  @override
  final String? stripePaymentMethodId;
  @override
  final DateTime? createdAt;
  @override
  final String? userId;

  @override
  String toString() {
    return 'PaymentCard(id: $id, lastFourDigits: $lastFourDigits, cardType: $cardType, cardHolderName: $cardHolderName, expiryMonth: $expiryMonth, expiryYear: $expiryYear, stripeCustomerId: $stripeCustomerId, isDefault: $isDefault, stripePaymentMethodId: $stripePaymentMethodId, createdAt: $createdAt, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lastFourDigits, lastFourDigits) ||
                other.lastFourDigits == lastFourDigits) &&
            (identical(other.cardType, cardType) ||
                other.cardType == cardType) &&
            (identical(other.cardHolderName, cardHolderName) ||
                other.cardHolderName == cardHolderName) &&
            (identical(other.expiryMonth, expiryMonth) ||
                other.expiryMonth == expiryMonth) &&
            (identical(other.expiryYear, expiryYear) ||
                other.expiryYear == expiryYear) &&
            (identical(other.stripeCustomerId, stripeCustomerId) ||
                other.stripeCustomerId == stripeCustomerId) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.stripePaymentMethodId, stripePaymentMethodId) ||
                other.stripePaymentMethodId == stripePaymentMethodId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      lastFourDigits,
      cardType,
      cardHolderName,
      expiryMonth,
      expiryYear,
      stripeCustomerId,
      isDefault,
      stripePaymentMethodId,
      createdAt,
      userId);

  /// Create a copy of PaymentCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentCardImplCopyWith<_$PaymentCardImpl> get copyWith =>
      __$$PaymentCardImplCopyWithImpl<_$PaymentCardImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String lastFourDigits,
            CardType cardType,
            String cardHolderName,
            String expiryMonth,
            String expiryYear,
            String? stripeCustomerId,
            bool isDefault,
            String? stripePaymentMethodId,
            DateTime? createdAt,
            String? userId)
        $default,
  ) {
    return $default(
        id,
        lastFourDigits,
        cardType,
        cardHolderName,
        expiryMonth,
        expiryYear,
        stripeCustomerId,
        isDefault,
        stripePaymentMethodId,
        createdAt,
        userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String lastFourDigits,
            CardType cardType,
            String cardHolderName,
            String expiryMonth,
            String expiryYear,
            String? stripeCustomerId,
            bool isDefault,
            String? stripePaymentMethodId,
            DateTime? createdAt,
            String? userId)?
        $default,
  ) {
    return $default?.call(
        id,
        lastFourDigits,
        cardType,
        cardHolderName,
        expiryMonth,
        expiryYear,
        stripeCustomerId,
        isDefault,
        stripePaymentMethodId,
        createdAt,
        userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String lastFourDigits,
            CardType cardType,
            String cardHolderName,
            String expiryMonth,
            String expiryYear,
            String? stripeCustomerId,
            bool isDefault,
            String? stripePaymentMethodId,
            DateTime? createdAt,
            String? userId)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          id,
          lastFourDigits,
          cardType,
          cardHolderName,
          expiryMonth,
          expiryYear,
          stripeCustomerId,
          isDefault,
          stripePaymentMethodId,
          createdAt,
          userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PaymentCard value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PaymentCard value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PaymentCard value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentCardImplToJson(
      this,
    );
  }
}

abstract class _PaymentCard extends PaymentCard {
  const factory _PaymentCard(
      {required final String id,
      required final String lastFourDigits,
      required final CardType cardType,
      required final String cardHolderName,
      required final String expiryMonth,
      required final String expiryYear,
      final String? stripeCustomerId,
      final bool isDefault,
      final String? stripePaymentMethodId,
      final DateTime? createdAt,
      final String? userId}) = _$PaymentCardImpl;
  const _PaymentCard._() : super._();

  factory _PaymentCard.fromJson(Map<String, dynamic> json) =
      _$PaymentCardImpl.fromJson;

  @override
  String get id;
  @override
  String get lastFourDigits;
  @override
  CardType get cardType;
  @override
  String get cardHolderName;
  @override
  String get expiryMonth;
  @override
  String get expiryYear;
  @override
  String? get stripeCustomerId;
  @override
  bool get isDefault;
  @override
  String? get stripePaymentMethodId;
  @override
  DateTime? get createdAt;
  @override
  String? get userId;

  /// Create a copy of PaymentCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentCardImplCopyWith<_$PaymentCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
