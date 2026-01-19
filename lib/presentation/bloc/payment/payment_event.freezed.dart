// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PaymentEvent {
  String get userId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadCards,
    required TResult Function(
            String userId,
            String cardNumber,
            String expiryMonth,
            String expiryYear,
            String cvv,
            String cardHolderName)
        addCard,
    required TResult Function(String userId, String cardId) deleteCard,
    required TResult Function(String userId, String cardId) setDefaultCard,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadCards,
    TResult? Function(String userId, String cardNumber, String expiryMonth,
            String expiryYear, String cvv, String cardHolderName)?
        addCard,
    TResult? Function(String userId, String cardId)? deleteCard,
    TResult? Function(String userId, String cardId)? setDefaultCard,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadCards,
    TResult Function(String userId, String cardNumber, String expiryMonth,
            String expiryYear, String cvv, String cardHolderName)?
        addCard,
    TResult Function(String userId, String cardId)? deleteCard,
    TResult Function(String userId, String cardId)? setDefaultCard,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadCardsEvent value) loadCards,
    required TResult Function(AddCardEvent value) addCard,
    required TResult Function(DeleteCardEvent value) deleteCard,
    required TResult Function(SetDefaultCardEvent value) setDefaultCard,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadCardsEvent value)? loadCards,
    TResult? Function(AddCardEvent value)? addCard,
    TResult? Function(DeleteCardEvent value)? deleteCard,
    TResult? Function(SetDefaultCardEvent value)? setDefaultCard,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadCardsEvent value)? loadCards,
    TResult Function(AddCardEvent value)? addCard,
    TResult Function(DeleteCardEvent value)? deleteCard,
    TResult Function(SetDefaultCardEvent value)? setDefaultCard,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentEventCopyWith<PaymentEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentEventCopyWith<$Res> {
  factory $PaymentEventCopyWith(
          PaymentEvent value, $Res Function(PaymentEvent) then) =
      _$PaymentEventCopyWithImpl<$Res, PaymentEvent>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class _$PaymentEventCopyWithImpl<$Res, $Val extends PaymentEvent>
    implements $PaymentEventCopyWith<$Res> {
  _$PaymentEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadCardsEventImplCopyWith<$Res>
    implements $PaymentEventCopyWith<$Res> {
  factory _$$LoadCardsEventImplCopyWith(_$LoadCardsEventImpl value,
          $Res Function(_$LoadCardsEventImpl) then) =
      __$$LoadCardsEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$LoadCardsEventImplCopyWithImpl<$Res>
    extends _$PaymentEventCopyWithImpl<$Res, _$LoadCardsEventImpl>
    implements _$$LoadCardsEventImplCopyWith<$Res> {
  __$$LoadCardsEventImplCopyWithImpl(
      _$LoadCardsEventImpl _value, $Res Function(_$LoadCardsEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_$LoadCardsEventImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadCardsEventImpl implements LoadCardsEvent {
  const _$LoadCardsEventImpl({required this.userId});

  @override
  final String userId;

  @override
  String toString() {
    return 'PaymentEvent.loadCards(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadCardsEventImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadCardsEventImplCopyWith<_$LoadCardsEventImpl> get copyWith =>
      __$$LoadCardsEventImplCopyWithImpl<_$LoadCardsEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadCards,
    required TResult Function(
            String userId,
            String cardNumber,
            String expiryMonth,
            String expiryYear,
            String cvv,
            String cardHolderName)
        addCard,
    required TResult Function(String userId, String cardId) deleteCard,
    required TResult Function(String userId, String cardId) setDefaultCard,
  }) {
    return loadCards(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadCards,
    TResult? Function(String userId, String cardNumber, String expiryMonth,
            String expiryYear, String cvv, String cardHolderName)?
        addCard,
    TResult? Function(String userId, String cardId)? deleteCard,
    TResult? Function(String userId, String cardId)? setDefaultCard,
  }) {
    return loadCards?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadCards,
    TResult Function(String userId, String cardNumber, String expiryMonth,
            String expiryYear, String cvv, String cardHolderName)?
        addCard,
    TResult Function(String userId, String cardId)? deleteCard,
    TResult Function(String userId, String cardId)? setDefaultCard,
    required TResult orElse(),
  }) {
    if (loadCards != null) {
      return loadCards(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadCardsEvent value) loadCards,
    required TResult Function(AddCardEvent value) addCard,
    required TResult Function(DeleteCardEvent value) deleteCard,
    required TResult Function(SetDefaultCardEvent value) setDefaultCard,
  }) {
    return loadCards(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadCardsEvent value)? loadCards,
    TResult? Function(AddCardEvent value)? addCard,
    TResult? Function(DeleteCardEvent value)? deleteCard,
    TResult? Function(SetDefaultCardEvent value)? setDefaultCard,
  }) {
    return loadCards?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadCardsEvent value)? loadCards,
    TResult Function(AddCardEvent value)? addCard,
    TResult Function(DeleteCardEvent value)? deleteCard,
    TResult Function(SetDefaultCardEvent value)? setDefaultCard,
    required TResult orElse(),
  }) {
    if (loadCards != null) {
      return loadCards(this);
    }
    return orElse();
  }
}

abstract class LoadCardsEvent implements PaymentEvent {
  const factory LoadCardsEvent({required final String userId}) =
      _$LoadCardsEventImpl;

  @override
  String get userId;

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadCardsEventImplCopyWith<_$LoadCardsEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddCardEventImplCopyWith<$Res>
    implements $PaymentEventCopyWith<$Res> {
  factory _$$AddCardEventImplCopyWith(
          _$AddCardEventImpl value, $Res Function(_$AddCardEventImpl) then) =
      __$$AddCardEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String cardNumber,
      String expiryMonth,
      String expiryYear,
      String cvv,
      String cardHolderName});
}

/// @nodoc
class __$$AddCardEventImplCopyWithImpl<$Res>
    extends _$PaymentEventCopyWithImpl<$Res, _$AddCardEventImpl>
    implements _$$AddCardEventImplCopyWith<$Res> {
  __$$AddCardEventImplCopyWithImpl(
      _$AddCardEventImpl _value, $Res Function(_$AddCardEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? cardNumber = null,
    Object? expiryMonth = null,
    Object? expiryYear = null,
    Object? cvv = null,
    Object? cardHolderName = null,
  }) {
    return _then(_$AddCardEventImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      cardNumber: null == cardNumber
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String,
      expiryMonth: null == expiryMonth
          ? _value.expiryMonth
          : expiryMonth // ignore: cast_nullable_to_non_nullable
              as String,
      expiryYear: null == expiryYear
          ? _value.expiryYear
          : expiryYear // ignore: cast_nullable_to_non_nullable
              as String,
      cvv: null == cvv
          ? _value.cvv
          : cvv // ignore: cast_nullable_to_non_nullable
              as String,
      cardHolderName: null == cardHolderName
          ? _value.cardHolderName
          : cardHolderName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddCardEventImpl implements AddCardEvent {
  const _$AddCardEventImpl(
      {required this.userId,
      required this.cardNumber,
      required this.expiryMonth,
      required this.expiryYear,
      required this.cvv,
      required this.cardHolderName});

  @override
  final String userId;
  @override
  final String cardNumber;
  @override
  final String expiryMonth;
  @override
  final String expiryYear;
  @override
  final String cvv;
  @override
  final String cardHolderName;

  @override
  String toString() {
    return 'PaymentEvent.addCard(userId: $userId, cardNumber: $cardNumber, expiryMonth: $expiryMonth, expiryYear: $expiryYear, cvv: $cvv, cardHolderName: $cardHolderName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCardEventImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.cardNumber, cardNumber) ||
                other.cardNumber == cardNumber) &&
            (identical(other.expiryMonth, expiryMonth) ||
                other.expiryMonth == expiryMonth) &&
            (identical(other.expiryYear, expiryYear) ||
                other.expiryYear == expiryYear) &&
            (identical(other.cvv, cvv) || other.cvv == cvv) &&
            (identical(other.cardHolderName, cardHolderName) ||
                other.cardHolderName == cardHolderName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, cardNumber, expiryMonth,
      expiryYear, cvv, cardHolderName);

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddCardEventImplCopyWith<_$AddCardEventImpl> get copyWith =>
      __$$AddCardEventImplCopyWithImpl<_$AddCardEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadCards,
    required TResult Function(
            String userId,
            String cardNumber,
            String expiryMonth,
            String expiryYear,
            String cvv,
            String cardHolderName)
        addCard,
    required TResult Function(String userId, String cardId) deleteCard,
    required TResult Function(String userId, String cardId) setDefaultCard,
  }) {
    return addCard(
        userId, cardNumber, expiryMonth, expiryYear, cvv, cardHolderName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadCards,
    TResult? Function(String userId, String cardNumber, String expiryMonth,
            String expiryYear, String cvv, String cardHolderName)?
        addCard,
    TResult? Function(String userId, String cardId)? deleteCard,
    TResult? Function(String userId, String cardId)? setDefaultCard,
  }) {
    return addCard?.call(
        userId, cardNumber, expiryMonth, expiryYear, cvv, cardHolderName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadCards,
    TResult Function(String userId, String cardNumber, String expiryMonth,
            String expiryYear, String cvv, String cardHolderName)?
        addCard,
    TResult Function(String userId, String cardId)? deleteCard,
    TResult Function(String userId, String cardId)? setDefaultCard,
    required TResult orElse(),
  }) {
    if (addCard != null) {
      return addCard(
          userId, cardNumber, expiryMonth, expiryYear, cvv, cardHolderName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadCardsEvent value) loadCards,
    required TResult Function(AddCardEvent value) addCard,
    required TResult Function(DeleteCardEvent value) deleteCard,
    required TResult Function(SetDefaultCardEvent value) setDefaultCard,
  }) {
    return addCard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadCardsEvent value)? loadCards,
    TResult? Function(AddCardEvent value)? addCard,
    TResult? Function(DeleteCardEvent value)? deleteCard,
    TResult? Function(SetDefaultCardEvent value)? setDefaultCard,
  }) {
    return addCard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadCardsEvent value)? loadCards,
    TResult Function(AddCardEvent value)? addCard,
    TResult Function(DeleteCardEvent value)? deleteCard,
    TResult Function(SetDefaultCardEvent value)? setDefaultCard,
    required TResult orElse(),
  }) {
    if (addCard != null) {
      return addCard(this);
    }
    return orElse();
  }
}

abstract class AddCardEvent implements PaymentEvent {
  const factory AddCardEvent(
      {required final String userId,
      required final String cardNumber,
      required final String expiryMonth,
      required final String expiryYear,
      required final String cvv,
      required final String cardHolderName}) = _$AddCardEventImpl;

  @override
  String get userId;
  String get cardNumber;
  String get expiryMonth;
  String get expiryYear;
  String get cvv;
  String get cardHolderName;

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddCardEventImplCopyWith<_$AddCardEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteCardEventImplCopyWith<$Res>
    implements $PaymentEventCopyWith<$Res> {
  factory _$$DeleteCardEventImplCopyWith(_$DeleteCardEventImpl value,
          $Res Function(_$DeleteCardEventImpl) then) =
      __$$DeleteCardEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String cardId});
}

/// @nodoc
class __$$DeleteCardEventImplCopyWithImpl<$Res>
    extends _$PaymentEventCopyWithImpl<$Res, _$DeleteCardEventImpl>
    implements _$$DeleteCardEventImplCopyWith<$Res> {
  __$$DeleteCardEventImplCopyWithImpl(
      _$DeleteCardEventImpl _value, $Res Function(_$DeleteCardEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? cardId = null,
  }) {
    return _then(_$DeleteCardEventImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      cardId: null == cardId
          ? _value.cardId
          : cardId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteCardEventImpl implements DeleteCardEvent {
  const _$DeleteCardEventImpl({required this.userId, required this.cardId});

  @override
  final String userId;
  @override
  final String cardId;

  @override
  String toString() {
    return 'PaymentEvent.deleteCard(userId: $userId, cardId: $cardId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCardEventImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.cardId, cardId) || other.cardId == cardId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, cardId);

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteCardEventImplCopyWith<_$DeleteCardEventImpl> get copyWith =>
      __$$DeleteCardEventImplCopyWithImpl<_$DeleteCardEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadCards,
    required TResult Function(
            String userId,
            String cardNumber,
            String expiryMonth,
            String expiryYear,
            String cvv,
            String cardHolderName)
        addCard,
    required TResult Function(String userId, String cardId) deleteCard,
    required TResult Function(String userId, String cardId) setDefaultCard,
  }) {
    return deleteCard(userId, cardId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadCards,
    TResult? Function(String userId, String cardNumber, String expiryMonth,
            String expiryYear, String cvv, String cardHolderName)?
        addCard,
    TResult? Function(String userId, String cardId)? deleteCard,
    TResult? Function(String userId, String cardId)? setDefaultCard,
  }) {
    return deleteCard?.call(userId, cardId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadCards,
    TResult Function(String userId, String cardNumber, String expiryMonth,
            String expiryYear, String cvv, String cardHolderName)?
        addCard,
    TResult Function(String userId, String cardId)? deleteCard,
    TResult Function(String userId, String cardId)? setDefaultCard,
    required TResult orElse(),
  }) {
    if (deleteCard != null) {
      return deleteCard(userId, cardId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadCardsEvent value) loadCards,
    required TResult Function(AddCardEvent value) addCard,
    required TResult Function(DeleteCardEvent value) deleteCard,
    required TResult Function(SetDefaultCardEvent value) setDefaultCard,
  }) {
    return deleteCard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadCardsEvent value)? loadCards,
    TResult? Function(AddCardEvent value)? addCard,
    TResult? Function(DeleteCardEvent value)? deleteCard,
    TResult? Function(SetDefaultCardEvent value)? setDefaultCard,
  }) {
    return deleteCard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadCardsEvent value)? loadCards,
    TResult Function(AddCardEvent value)? addCard,
    TResult Function(DeleteCardEvent value)? deleteCard,
    TResult Function(SetDefaultCardEvent value)? setDefaultCard,
    required TResult orElse(),
  }) {
    if (deleteCard != null) {
      return deleteCard(this);
    }
    return orElse();
  }
}

abstract class DeleteCardEvent implements PaymentEvent {
  const factory DeleteCardEvent(
      {required final String userId,
      required final String cardId}) = _$DeleteCardEventImpl;

  @override
  String get userId;
  String get cardId;

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteCardEventImplCopyWith<_$DeleteCardEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetDefaultCardEventImplCopyWith<$Res>
    implements $PaymentEventCopyWith<$Res> {
  factory _$$SetDefaultCardEventImplCopyWith(_$SetDefaultCardEventImpl value,
          $Res Function(_$SetDefaultCardEventImpl) then) =
      __$$SetDefaultCardEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String cardId});
}

/// @nodoc
class __$$SetDefaultCardEventImplCopyWithImpl<$Res>
    extends _$PaymentEventCopyWithImpl<$Res, _$SetDefaultCardEventImpl>
    implements _$$SetDefaultCardEventImplCopyWith<$Res> {
  __$$SetDefaultCardEventImplCopyWithImpl(_$SetDefaultCardEventImpl _value,
      $Res Function(_$SetDefaultCardEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? cardId = null,
  }) {
    return _then(_$SetDefaultCardEventImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      cardId: null == cardId
          ? _value.cardId
          : cardId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SetDefaultCardEventImpl implements SetDefaultCardEvent {
  const _$SetDefaultCardEventImpl({required this.userId, required this.cardId});

  @override
  final String userId;
  @override
  final String cardId;

  @override
  String toString() {
    return 'PaymentEvent.setDefaultCard(userId: $userId, cardId: $cardId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetDefaultCardEventImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.cardId, cardId) || other.cardId == cardId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, cardId);

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetDefaultCardEventImplCopyWith<_$SetDefaultCardEventImpl> get copyWith =>
      __$$SetDefaultCardEventImplCopyWithImpl<_$SetDefaultCardEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadCards,
    required TResult Function(
            String userId,
            String cardNumber,
            String expiryMonth,
            String expiryYear,
            String cvv,
            String cardHolderName)
        addCard,
    required TResult Function(String userId, String cardId) deleteCard,
    required TResult Function(String userId, String cardId) setDefaultCard,
  }) {
    return setDefaultCard(userId, cardId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadCards,
    TResult? Function(String userId, String cardNumber, String expiryMonth,
            String expiryYear, String cvv, String cardHolderName)?
        addCard,
    TResult? Function(String userId, String cardId)? deleteCard,
    TResult? Function(String userId, String cardId)? setDefaultCard,
  }) {
    return setDefaultCard?.call(userId, cardId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadCards,
    TResult Function(String userId, String cardNumber, String expiryMonth,
            String expiryYear, String cvv, String cardHolderName)?
        addCard,
    TResult Function(String userId, String cardId)? deleteCard,
    TResult Function(String userId, String cardId)? setDefaultCard,
    required TResult orElse(),
  }) {
    if (setDefaultCard != null) {
      return setDefaultCard(userId, cardId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadCardsEvent value) loadCards,
    required TResult Function(AddCardEvent value) addCard,
    required TResult Function(DeleteCardEvent value) deleteCard,
    required TResult Function(SetDefaultCardEvent value) setDefaultCard,
  }) {
    return setDefaultCard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadCardsEvent value)? loadCards,
    TResult? Function(AddCardEvent value)? addCard,
    TResult? Function(DeleteCardEvent value)? deleteCard,
    TResult? Function(SetDefaultCardEvent value)? setDefaultCard,
  }) {
    return setDefaultCard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadCardsEvent value)? loadCards,
    TResult Function(AddCardEvent value)? addCard,
    TResult Function(DeleteCardEvent value)? deleteCard,
    TResult Function(SetDefaultCardEvent value)? setDefaultCard,
    required TResult orElse(),
  }) {
    if (setDefaultCard != null) {
      return setDefaultCard(this);
    }
    return orElse();
  }
}

abstract class SetDefaultCardEvent implements PaymentEvent {
  const factory SetDefaultCardEvent(
      {required final String userId,
      required final String cardId}) = _$SetDefaultCardEventImpl;

  @override
  String get userId;
  String get cardId;

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetDefaultCardEventImplCopyWith<_$SetDefaultCardEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
