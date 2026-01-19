// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_intent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaymentIntent _$PaymentIntentFromJson(Map<String, dynamic> json) {
  return _PaymentIntent.fromJson(json);
}

/// @nodoc
mixin _$PaymentIntent {
  String get id => throw _privateConstructorUsedError;
  String get clientSecret => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError; // En centavos
  String get currency => throw _privateConstructorUsedError;
  PaymentStatus get status => throw _privateConstructorUsedError;
  String? get paymentMethodId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String clientSecret,
            int amount,
            String currency,
            PaymentStatus status,
            String? paymentMethodId,
            Map<String, dynamic>? metadata)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String clientSecret,
            int amount,
            String currency,
            PaymentStatus status,
            String? paymentMethodId,
            Map<String, dynamic>? metadata)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String clientSecret,
            int amount,
            String currency,
            PaymentStatus status,
            String? paymentMethodId,
            Map<String, dynamic>? metadata)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PaymentIntent value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PaymentIntent value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PaymentIntent value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this PaymentIntent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentIntent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentIntentCopyWith<PaymentIntent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentIntentCopyWith<$Res> {
  factory $PaymentIntentCopyWith(
          PaymentIntent value, $Res Function(PaymentIntent) then) =
      _$PaymentIntentCopyWithImpl<$Res, PaymentIntent>;
  @useResult
  $Res call(
      {String id,
      String clientSecret,
      int amount,
      String currency,
      PaymentStatus status,
      String? paymentMethodId,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$PaymentIntentCopyWithImpl<$Res, $Val extends PaymentIntent>
    implements $PaymentIntentCopyWith<$Res> {
  _$PaymentIntentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentIntent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientSecret = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? paymentMethodId = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientSecret: null == clientSecret
          ? _value.clientSecret
          : clientSecret // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      paymentMethodId: freezed == paymentMethodId
          ? _value.paymentMethodId
          : paymentMethodId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentIntentImplCopyWith<$Res>
    implements $PaymentIntentCopyWith<$Res> {
  factory _$$PaymentIntentImplCopyWith(
          _$PaymentIntentImpl value, $Res Function(_$PaymentIntentImpl) then) =
      __$$PaymentIntentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String clientSecret,
      int amount,
      String currency,
      PaymentStatus status,
      String? paymentMethodId,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$PaymentIntentImplCopyWithImpl<$Res>
    extends _$PaymentIntentCopyWithImpl<$Res, _$PaymentIntentImpl>
    implements _$$PaymentIntentImplCopyWith<$Res> {
  __$$PaymentIntentImplCopyWithImpl(
      _$PaymentIntentImpl _value, $Res Function(_$PaymentIntentImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentIntent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientSecret = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? paymentMethodId = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$PaymentIntentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientSecret: null == clientSecret
          ? _value.clientSecret
          : clientSecret // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      paymentMethodId: freezed == paymentMethodId
          ? _value.paymentMethodId
          : paymentMethodId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentIntentImpl extends _PaymentIntent {
  const _$PaymentIntentImpl(
      {required this.id,
      required this.clientSecret,
      required this.amount,
      required this.currency,
      required this.status,
      this.paymentMethodId,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata,
        super._();

  factory _$PaymentIntentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentIntentImplFromJson(json);

  @override
  final String id;
  @override
  final String clientSecret;
  @override
  final int amount;
// En centavos
  @override
  final String currency;
  @override
  final PaymentStatus status;
  @override
  final String? paymentMethodId;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'PaymentIntent(id: $id, clientSecret: $clientSecret, amount: $amount, currency: $currency, status: $status, paymentMethodId: $paymentMethodId, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentIntentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientSecret, clientSecret) ||
                other.clientSecret == clientSecret) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentMethodId, paymentMethodId) ||
                other.paymentMethodId == paymentMethodId) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      clientSecret,
      amount,
      currency,
      status,
      paymentMethodId,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of PaymentIntent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentIntentImplCopyWith<_$PaymentIntentImpl> get copyWith =>
      __$$PaymentIntentImplCopyWithImpl<_$PaymentIntentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String clientSecret,
            int amount,
            String currency,
            PaymentStatus status,
            String? paymentMethodId,
            Map<String, dynamic>? metadata)
        $default,
  ) {
    return $default(
        id, clientSecret, amount, currency, status, paymentMethodId, metadata);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String clientSecret,
            int amount,
            String currency,
            PaymentStatus status,
            String? paymentMethodId,
            Map<String, dynamic>? metadata)?
        $default,
  ) {
    return $default?.call(
        id, clientSecret, amount, currency, status, paymentMethodId, metadata);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String clientSecret,
            int amount,
            String currency,
            PaymentStatus status,
            String? paymentMethodId,
            Map<String, dynamic>? metadata)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(id, clientSecret, amount, currency, status,
          paymentMethodId, metadata);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PaymentIntent value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PaymentIntent value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PaymentIntent value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentIntentImplToJson(
      this,
    );
  }
}

abstract class _PaymentIntent extends PaymentIntent {
  const factory _PaymentIntent(
      {required final String id,
      required final String clientSecret,
      required final int amount,
      required final String currency,
      required final PaymentStatus status,
      final String? paymentMethodId,
      final Map<String, dynamic>? metadata}) = _$PaymentIntentImpl;
  const _PaymentIntent._() : super._();

  factory _PaymentIntent.fromJson(Map<String, dynamic> json) =
      _$PaymentIntentImpl.fromJson;

  @override
  String get id;
  @override
  String get clientSecret;
  @override
  int get amount; // En centavos
  @override
  String get currency;
  @override
  PaymentStatus get status;
  @override
  String? get paymentMethodId;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of PaymentIntent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentIntentImplCopyWith<_$PaymentIntentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
