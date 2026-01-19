// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PaymentState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentCard> cards) loaded,
    required TResult Function(
            PaymentCard card, List<PaymentCard> cards, String message)
        cardAdded,
    required TResult Function(List<PaymentCard> cards, String message)
        cardDeleted,
    required TResult Function(List<PaymentCard> cards, String message)
        defaultCardUpdated,
    required TResult Function(String message, List<PaymentCard>? cards) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentCard> cards)? loaded,
    TResult? Function(
            PaymentCard card, List<PaymentCard> cards, String message)?
        cardAdded,
    TResult? Function(List<PaymentCard> cards, String message)? cardDeleted,
    TResult? Function(List<PaymentCard> cards, String message)?
        defaultCardUpdated,
    TResult? Function(String message, List<PaymentCard>? cards)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentCard> cards)? loaded,
    TResult Function(PaymentCard card, List<PaymentCard> cards, String message)?
        cardAdded,
    TResult Function(List<PaymentCard> cards, String message)? cardDeleted,
    TResult Function(List<PaymentCard> cards, String message)?
        defaultCardUpdated,
    TResult Function(String message, List<PaymentCard>? cards)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PaymentInitial value) initial,
    required TResult Function(PaymentLoading value) loading,
    required TResult Function(PaymentLoaded value) loaded,
    required TResult Function(CardAdded value) cardAdded,
    required TResult Function(CardDeleted value) cardDeleted,
    required TResult Function(DefaultCardUpdated value) defaultCardUpdated,
    required TResult Function(PaymentError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PaymentInitial value)? initial,
    TResult? Function(PaymentLoading value)? loading,
    TResult? Function(PaymentLoaded value)? loaded,
    TResult? Function(CardAdded value)? cardAdded,
    TResult? Function(CardDeleted value)? cardDeleted,
    TResult? Function(DefaultCardUpdated value)? defaultCardUpdated,
    TResult? Function(PaymentError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PaymentInitial value)? initial,
    TResult Function(PaymentLoading value)? loading,
    TResult Function(PaymentLoaded value)? loaded,
    TResult Function(CardAdded value)? cardAdded,
    TResult Function(CardDeleted value)? cardDeleted,
    TResult Function(DefaultCardUpdated value)? defaultCardUpdated,
    TResult Function(PaymentError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentStateCopyWith<$Res> {
  factory $PaymentStateCopyWith(
          PaymentState value, $Res Function(PaymentState) then) =
      _$PaymentStateCopyWithImpl<$Res, PaymentState>;
}

/// @nodoc
class _$PaymentStateCopyWithImpl<$Res, $Val extends PaymentState>
    implements $PaymentStateCopyWith<$Res> {
  _$PaymentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PaymentInitialImplCopyWith<$Res> {
  factory _$$PaymentInitialImplCopyWith(_$PaymentInitialImpl value,
          $Res Function(_$PaymentInitialImpl) then) =
      __$$PaymentInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PaymentInitialImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$PaymentInitialImpl>
    implements _$$PaymentInitialImplCopyWith<$Res> {
  __$$PaymentInitialImplCopyWithImpl(
      _$PaymentInitialImpl _value, $Res Function(_$PaymentInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PaymentInitialImpl implements PaymentInitial {
  const _$PaymentInitialImpl();

  @override
  String toString() {
    return 'PaymentState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PaymentInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentCard> cards) loaded,
    required TResult Function(
            PaymentCard card, List<PaymentCard> cards, String message)
        cardAdded,
    required TResult Function(List<PaymentCard> cards, String message)
        cardDeleted,
    required TResult Function(List<PaymentCard> cards, String message)
        defaultCardUpdated,
    required TResult Function(String message, List<PaymentCard>? cards) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentCard> cards)? loaded,
    TResult? Function(
            PaymentCard card, List<PaymentCard> cards, String message)?
        cardAdded,
    TResult? Function(List<PaymentCard> cards, String message)? cardDeleted,
    TResult? Function(List<PaymentCard> cards, String message)?
        defaultCardUpdated,
    TResult? Function(String message, List<PaymentCard>? cards)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentCard> cards)? loaded,
    TResult Function(PaymentCard card, List<PaymentCard> cards, String message)?
        cardAdded,
    TResult Function(List<PaymentCard> cards, String message)? cardDeleted,
    TResult Function(List<PaymentCard> cards, String message)?
        defaultCardUpdated,
    TResult Function(String message, List<PaymentCard>? cards)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PaymentInitial value) initial,
    required TResult Function(PaymentLoading value) loading,
    required TResult Function(PaymentLoaded value) loaded,
    required TResult Function(CardAdded value) cardAdded,
    required TResult Function(CardDeleted value) cardDeleted,
    required TResult Function(DefaultCardUpdated value) defaultCardUpdated,
    required TResult Function(PaymentError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PaymentInitial value)? initial,
    TResult? Function(PaymentLoading value)? loading,
    TResult? Function(PaymentLoaded value)? loaded,
    TResult? Function(CardAdded value)? cardAdded,
    TResult? Function(CardDeleted value)? cardDeleted,
    TResult? Function(DefaultCardUpdated value)? defaultCardUpdated,
    TResult? Function(PaymentError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PaymentInitial value)? initial,
    TResult Function(PaymentLoading value)? loading,
    TResult Function(PaymentLoaded value)? loaded,
    TResult Function(CardAdded value)? cardAdded,
    TResult Function(CardDeleted value)? cardDeleted,
    TResult Function(DefaultCardUpdated value)? defaultCardUpdated,
    TResult Function(PaymentError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PaymentInitial implements PaymentState {
  const factory PaymentInitial() = _$PaymentInitialImpl;
}

/// @nodoc
abstract class _$$PaymentLoadingImplCopyWith<$Res> {
  factory _$$PaymentLoadingImplCopyWith(_$PaymentLoadingImpl value,
          $Res Function(_$PaymentLoadingImpl) then) =
      __$$PaymentLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PaymentLoadingImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$PaymentLoadingImpl>
    implements _$$PaymentLoadingImplCopyWith<$Res> {
  __$$PaymentLoadingImplCopyWithImpl(
      _$PaymentLoadingImpl _value, $Res Function(_$PaymentLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PaymentLoadingImpl implements PaymentLoading {
  const _$PaymentLoadingImpl();

  @override
  String toString() {
    return 'PaymentState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PaymentLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentCard> cards) loaded,
    required TResult Function(
            PaymentCard card, List<PaymentCard> cards, String message)
        cardAdded,
    required TResult Function(List<PaymentCard> cards, String message)
        cardDeleted,
    required TResult Function(List<PaymentCard> cards, String message)
        defaultCardUpdated,
    required TResult Function(String message, List<PaymentCard>? cards) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentCard> cards)? loaded,
    TResult? Function(
            PaymentCard card, List<PaymentCard> cards, String message)?
        cardAdded,
    TResult? Function(List<PaymentCard> cards, String message)? cardDeleted,
    TResult? Function(List<PaymentCard> cards, String message)?
        defaultCardUpdated,
    TResult? Function(String message, List<PaymentCard>? cards)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentCard> cards)? loaded,
    TResult Function(PaymentCard card, List<PaymentCard> cards, String message)?
        cardAdded,
    TResult Function(List<PaymentCard> cards, String message)? cardDeleted,
    TResult Function(List<PaymentCard> cards, String message)?
        defaultCardUpdated,
    TResult Function(String message, List<PaymentCard>? cards)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PaymentInitial value) initial,
    required TResult Function(PaymentLoading value) loading,
    required TResult Function(PaymentLoaded value) loaded,
    required TResult Function(CardAdded value) cardAdded,
    required TResult Function(CardDeleted value) cardDeleted,
    required TResult Function(DefaultCardUpdated value) defaultCardUpdated,
    required TResult Function(PaymentError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PaymentInitial value)? initial,
    TResult? Function(PaymentLoading value)? loading,
    TResult? Function(PaymentLoaded value)? loaded,
    TResult? Function(CardAdded value)? cardAdded,
    TResult? Function(CardDeleted value)? cardDeleted,
    TResult? Function(DefaultCardUpdated value)? defaultCardUpdated,
    TResult? Function(PaymentError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PaymentInitial value)? initial,
    TResult Function(PaymentLoading value)? loading,
    TResult Function(PaymentLoaded value)? loaded,
    TResult Function(CardAdded value)? cardAdded,
    TResult Function(CardDeleted value)? cardDeleted,
    TResult Function(DefaultCardUpdated value)? defaultCardUpdated,
    TResult Function(PaymentError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PaymentLoading implements PaymentState {
  const factory PaymentLoading() = _$PaymentLoadingImpl;
}

/// @nodoc
abstract class _$$PaymentLoadedImplCopyWith<$Res> {
  factory _$$PaymentLoadedImplCopyWith(
          _$PaymentLoadedImpl value, $Res Function(_$PaymentLoadedImpl) then) =
      __$$PaymentLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PaymentCard> cards});
}

/// @nodoc
class __$$PaymentLoadedImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$PaymentLoadedImpl>
    implements _$$PaymentLoadedImplCopyWith<$Res> {
  __$$PaymentLoadedImplCopyWithImpl(
      _$PaymentLoadedImpl _value, $Res Function(_$PaymentLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
  }) {
    return _then(_$PaymentLoadedImpl(
      null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<PaymentCard>,
    ));
  }
}

/// @nodoc

class _$PaymentLoadedImpl implements PaymentLoaded {
  const _$PaymentLoadedImpl(final List<PaymentCard> cards) : _cards = cards;

  final List<PaymentCard> _cards;
  @override
  List<PaymentCard> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  String toString() {
    return 'PaymentState.loaded(cards: $cards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentLoadedImpl &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cards));

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentLoadedImplCopyWith<_$PaymentLoadedImpl> get copyWith =>
      __$$PaymentLoadedImplCopyWithImpl<_$PaymentLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentCard> cards) loaded,
    required TResult Function(
            PaymentCard card, List<PaymentCard> cards, String message)
        cardAdded,
    required TResult Function(List<PaymentCard> cards, String message)
        cardDeleted,
    required TResult Function(List<PaymentCard> cards, String message)
        defaultCardUpdated,
    required TResult Function(String message, List<PaymentCard>? cards) error,
  }) {
    return loaded(cards);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentCard> cards)? loaded,
    TResult? Function(
            PaymentCard card, List<PaymentCard> cards, String message)?
        cardAdded,
    TResult? Function(List<PaymentCard> cards, String message)? cardDeleted,
    TResult? Function(List<PaymentCard> cards, String message)?
        defaultCardUpdated,
    TResult? Function(String message, List<PaymentCard>? cards)? error,
  }) {
    return loaded?.call(cards);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentCard> cards)? loaded,
    TResult Function(PaymentCard card, List<PaymentCard> cards, String message)?
        cardAdded,
    TResult Function(List<PaymentCard> cards, String message)? cardDeleted,
    TResult Function(List<PaymentCard> cards, String message)?
        defaultCardUpdated,
    TResult Function(String message, List<PaymentCard>? cards)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(cards);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PaymentInitial value) initial,
    required TResult Function(PaymentLoading value) loading,
    required TResult Function(PaymentLoaded value) loaded,
    required TResult Function(CardAdded value) cardAdded,
    required TResult Function(CardDeleted value) cardDeleted,
    required TResult Function(DefaultCardUpdated value) defaultCardUpdated,
    required TResult Function(PaymentError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PaymentInitial value)? initial,
    TResult? Function(PaymentLoading value)? loading,
    TResult? Function(PaymentLoaded value)? loaded,
    TResult? Function(CardAdded value)? cardAdded,
    TResult? Function(CardDeleted value)? cardDeleted,
    TResult? Function(DefaultCardUpdated value)? defaultCardUpdated,
    TResult? Function(PaymentError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PaymentInitial value)? initial,
    TResult Function(PaymentLoading value)? loading,
    TResult Function(PaymentLoaded value)? loaded,
    TResult Function(CardAdded value)? cardAdded,
    TResult Function(CardDeleted value)? cardDeleted,
    TResult Function(DefaultCardUpdated value)? defaultCardUpdated,
    TResult Function(PaymentError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class PaymentLoaded implements PaymentState {
  const factory PaymentLoaded(final List<PaymentCard> cards) =
      _$PaymentLoadedImpl;

  List<PaymentCard> get cards;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentLoadedImplCopyWith<_$PaymentLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CardAddedImplCopyWith<$Res> {
  factory _$$CardAddedImplCopyWith(
          _$CardAddedImpl value, $Res Function(_$CardAddedImpl) then) =
      __$$CardAddedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PaymentCard card, List<PaymentCard> cards, String message});

  $PaymentCardCopyWith<$Res> get card;
}

/// @nodoc
class __$$CardAddedImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$CardAddedImpl>
    implements _$$CardAddedImplCopyWith<$Res> {
  __$$CardAddedImplCopyWithImpl(
      _$CardAddedImpl _value, $Res Function(_$CardAddedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? card = null,
    Object? cards = null,
    Object? message = null,
  }) {
    return _then(_$CardAddedImpl(
      card: null == card
          ? _value.card
          : card // ignore: cast_nullable_to_non_nullable
              as PaymentCard,
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<PaymentCard>,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentCardCopyWith<$Res> get card {
    return $PaymentCardCopyWith<$Res>(_value.card, (value) {
      return _then(_value.copyWith(card: value));
    });
  }
}

/// @nodoc

class _$CardAddedImpl implements CardAdded {
  const _$CardAddedImpl(
      {required this.card,
      required final List<PaymentCard> cards,
      required this.message})
      : _cards = cards;

  @override
  final PaymentCard card;
  final List<PaymentCard> _cards;
  @override
  List<PaymentCard> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  final String message;

  @override
  String toString() {
    return 'PaymentState.cardAdded(card: $card, cards: $cards, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardAddedImpl &&
            (identical(other.card, card) || other.card == card) &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, card, const DeepCollectionEquality().hash(_cards), message);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CardAddedImplCopyWith<_$CardAddedImpl> get copyWith =>
      __$$CardAddedImplCopyWithImpl<_$CardAddedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentCard> cards) loaded,
    required TResult Function(
            PaymentCard card, List<PaymentCard> cards, String message)
        cardAdded,
    required TResult Function(List<PaymentCard> cards, String message)
        cardDeleted,
    required TResult Function(List<PaymentCard> cards, String message)
        defaultCardUpdated,
    required TResult Function(String message, List<PaymentCard>? cards) error,
  }) {
    return cardAdded(card, cards, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentCard> cards)? loaded,
    TResult? Function(
            PaymentCard card, List<PaymentCard> cards, String message)?
        cardAdded,
    TResult? Function(List<PaymentCard> cards, String message)? cardDeleted,
    TResult? Function(List<PaymentCard> cards, String message)?
        defaultCardUpdated,
    TResult? Function(String message, List<PaymentCard>? cards)? error,
  }) {
    return cardAdded?.call(card, cards, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentCard> cards)? loaded,
    TResult Function(PaymentCard card, List<PaymentCard> cards, String message)?
        cardAdded,
    TResult Function(List<PaymentCard> cards, String message)? cardDeleted,
    TResult Function(List<PaymentCard> cards, String message)?
        defaultCardUpdated,
    TResult Function(String message, List<PaymentCard>? cards)? error,
    required TResult orElse(),
  }) {
    if (cardAdded != null) {
      return cardAdded(card, cards, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PaymentInitial value) initial,
    required TResult Function(PaymentLoading value) loading,
    required TResult Function(PaymentLoaded value) loaded,
    required TResult Function(CardAdded value) cardAdded,
    required TResult Function(CardDeleted value) cardDeleted,
    required TResult Function(DefaultCardUpdated value) defaultCardUpdated,
    required TResult Function(PaymentError value) error,
  }) {
    return cardAdded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PaymentInitial value)? initial,
    TResult? Function(PaymentLoading value)? loading,
    TResult? Function(PaymentLoaded value)? loaded,
    TResult? Function(CardAdded value)? cardAdded,
    TResult? Function(CardDeleted value)? cardDeleted,
    TResult? Function(DefaultCardUpdated value)? defaultCardUpdated,
    TResult? Function(PaymentError value)? error,
  }) {
    return cardAdded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PaymentInitial value)? initial,
    TResult Function(PaymentLoading value)? loading,
    TResult Function(PaymentLoaded value)? loaded,
    TResult Function(CardAdded value)? cardAdded,
    TResult Function(CardDeleted value)? cardDeleted,
    TResult Function(DefaultCardUpdated value)? defaultCardUpdated,
    TResult Function(PaymentError value)? error,
    required TResult orElse(),
  }) {
    if (cardAdded != null) {
      return cardAdded(this);
    }
    return orElse();
  }
}

abstract class CardAdded implements PaymentState {
  const factory CardAdded(
      {required final PaymentCard card,
      required final List<PaymentCard> cards,
      required final String message}) = _$CardAddedImpl;

  PaymentCard get card;
  List<PaymentCard> get cards;
  String get message;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CardAddedImplCopyWith<_$CardAddedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CardDeletedImplCopyWith<$Res> {
  factory _$$CardDeletedImplCopyWith(
          _$CardDeletedImpl value, $Res Function(_$CardDeletedImpl) then) =
      __$$CardDeletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PaymentCard> cards, String message});
}

/// @nodoc
class __$$CardDeletedImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$CardDeletedImpl>
    implements _$$CardDeletedImplCopyWith<$Res> {
  __$$CardDeletedImplCopyWithImpl(
      _$CardDeletedImpl _value, $Res Function(_$CardDeletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? message = null,
  }) {
    return _then(_$CardDeletedImpl(
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<PaymentCard>,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CardDeletedImpl implements CardDeleted {
  const _$CardDeletedImpl(
      {required final List<PaymentCard> cards, required this.message})
      : _cards = cards;

  final List<PaymentCard> _cards;
  @override
  List<PaymentCard> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  final String message;

  @override
  String toString() {
    return 'PaymentState.cardDeleted(cards: $cards, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardDeletedImpl &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_cards), message);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CardDeletedImplCopyWith<_$CardDeletedImpl> get copyWith =>
      __$$CardDeletedImplCopyWithImpl<_$CardDeletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentCard> cards) loaded,
    required TResult Function(
            PaymentCard card, List<PaymentCard> cards, String message)
        cardAdded,
    required TResult Function(List<PaymentCard> cards, String message)
        cardDeleted,
    required TResult Function(List<PaymentCard> cards, String message)
        defaultCardUpdated,
    required TResult Function(String message, List<PaymentCard>? cards) error,
  }) {
    return cardDeleted(cards, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentCard> cards)? loaded,
    TResult? Function(
            PaymentCard card, List<PaymentCard> cards, String message)?
        cardAdded,
    TResult? Function(List<PaymentCard> cards, String message)? cardDeleted,
    TResult? Function(List<PaymentCard> cards, String message)?
        defaultCardUpdated,
    TResult? Function(String message, List<PaymentCard>? cards)? error,
  }) {
    return cardDeleted?.call(cards, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentCard> cards)? loaded,
    TResult Function(PaymentCard card, List<PaymentCard> cards, String message)?
        cardAdded,
    TResult Function(List<PaymentCard> cards, String message)? cardDeleted,
    TResult Function(List<PaymentCard> cards, String message)?
        defaultCardUpdated,
    TResult Function(String message, List<PaymentCard>? cards)? error,
    required TResult orElse(),
  }) {
    if (cardDeleted != null) {
      return cardDeleted(cards, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PaymentInitial value) initial,
    required TResult Function(PaymentLoading value) loading,
    required TResult Function(PaymentLoaded value) loaded,
    required TResult Function(CardAdded value) cardAdded,
    required TResult Function(CardDeleted value) cardDeleted,
    required TResult Function(DefaultCardUpdated value) defaultCardUpdated,
    required TResult Function(PaymentError value) error,
  }) {
    return cardDeleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PaymentInitial value)? initial,
    TResult? Function(PaymentLoading value)? loading,
    TResult? Function(PaymentLoaded value)? loaded,
    TResult? Function(CardAdded value)? cardAdded,
    TResult? Function(CardDeleted value)? cardDeleted,
    TResult? Function(DefaultCardUpdated value)? defaultCardUpdated,
    TResult? Function(PaymentError value)? error,
  }) {
    return cardDeleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PaymentInitial value)? initial,
    TResult Function(PaymentLoading value)? loading,
    TResult Function(PaymentLoaded value)? loaded,
    TResult Function(CardAdded value)? cardAdded,
    TResult Function(CardDeleted value)? cardDeleted,
    TResult Function(DefaultCardUpdated value)? defaultCardUpdated,
    TResult Function(PaymentError value)? error,
    required TResult orElse(),
  }) {
    if (cardDeleted != null) {
      return cardDeleted(this);
    }
    return orElse();
  }
}

abstract class CardDeleted implements PaymentState {
  const factory CardDeleted(
      {required final List<PaymentCard> cards,
      required final String message}) = _$CardDeletedImpl;

  List<PaymentCard> get cards;
  String get message;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CardDeletedImplCopyWith<_$CardDeletedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DefaultCardUpdatedImplCopyWith<$Res> {
  factory _$$DefaultCardUpdatedImplCopyWith(_$DefaultCardUpdatedImpl value,
          $Res Function(_$DefaultCardUpdatedImpl) then) =
      __$$DefaultCardUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PaymentCard> cards, String message});
}

/// @nodoc
class __$$DefaultCardUpdatedImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$DefaultCardUpdatedImpl>
    implements _$$DefaultCardUpdatedImplCopyWith<$Res> {
  __$$DefaultCardUpdatedImplCopyWithImpl(_$DefaultCardUpdatedImpl _value,
      $Res Function(_$DefaultCardUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? message = null,
  }) {
    return _then(_$DefaultCardUpdatedImpl(
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<PaymentCard>,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DefaultCardUpdatedImpl implements DefaultCardUpdated {
  const _$DefaultCardUpdatedImpl(
      {required final List<PaymentCard> cards, required this.message})
      : _cards = cards;

  final List<PaymentCard> _cards;
  @override
  List<PaymentCard> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  final String message;

  @override
  String toString() {
    return 'PaymentState.defaultCardUpdated(cards: $cards, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DefaultCardUpdatedImpl &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_cards), message);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DefaultCardUpdatedImplCopyWith<_$DefaultCardUpdatedImpl> get copyWith =>
      __$$DefaultCardUpdatedImplCopyWithImpl<_$DefaultCardUpdatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentCard> cards) loaded,
    required TResult Function(
            PaymentCard card, List<PaymentCard> cards, String message)
        cardAdded,
    required TResult Function(List<PaymentCard> cards, String message)
        cardDeleted,
    required TResult Function(List<PaymentCard> cards, String message)
        defaultCardUpdated,
    required TResult Function(String message, List<PaymentCard>? cards) error,
  }) {
    return defaultCardUpdated(cards, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentCard> cards)? loaded,
    TResult? Function(
            PaymentCard card, List<PaymentCard> cards, String message)?
        cardAdded,
    TResult? Function(List<PaymentCard> cards, String message)? cardDeleted,
    TResult? Function(List<PaymentCard> cards, String message)?
        defaultCardUpdated,
    TResult? Function(String message, List<PaymentCard>? cards)? error,
  }) {
    return defaultCardUpdated?.call(cards, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentCard> cards)? loaded,
    TResult Function(PaymentCard card, List<PaymentCard> cards, String message)?
        cardAdded,
    TResult Function(List<PaymentCard> cards, String message)? cardDeleted,
    TResult Function(List<PaymentCard> cards, String message)?
        defaultCardUpdated,
    TResult Function(String message, List<PaymentCard>? cards)? error,
    required TResult orElse(),
  }) {
    if (defaultCardUpdated != null) {
      return defaultCardUpdated(cards, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PaymentInitial value) initial,
    required TResult Function(PaymentLoading value) loading,
    required TResult Function(PaymentLoaded value) loaded,
    required TResult Function(CardAdded value) cardAdded,
    required TResult Function(CardDeleted value) cardDeleted,
    required TResult Function(DefaultCardUpdated value) defaultCardUpdated,
    required TResult Function(PaymentError value) error,
  }) {
    return defaultCardUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PaymentInitial value)? initial,
    TResult? Function(PaymentLoading value)? loading,
    TResult? Function(PaymentLoaded value)? loaded,
    TResult? Function(CardAdded value)? cardAdded,
    TResult? Function(CardDeleted value)? cardDeleted,
    TResult? Function(DefaultCardUpdated value)? defaultCardUpdated,
    TResult? Function(PaymentError value)? error,
  }) {
    return defaultCardUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PaymentInitial value)? initial,
    TResult Function(PaymentLoading value)? loading,
    TResult Function(PaymentLoaded value)? loaded,
    TResult Function(CardAdded value)? cardAdded,
    TResult Function(CardDeleted value)? cardDeleted,
    TResult Function(DefaultCardUpdated value)? defaultCardUpdated,
    TResult Function(PaymentError value)? error,
    required TResult orElse(),
  }) {
    if (defaultCardUpdated != null) {
      return defaultCardUpdated(this);
    }
    return orElse();
  }
}

abstract class DefaultCardUpdated implements PaymentState {
  const factory DefaultCardUpdated(
      {required final List<PaymentCard> cards,
      required final String message}) = _$DefaultCardUpdatedImpl;

  List<PaymentCard> get cards;
  String get message;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DefaultCardUpdatedImplCopyWith<_$DefaultCardUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PaymentErrorImplCopyWith<$Res> {
  factory _$$PaymentErrorImplCopyWith(
          _$PaymentErrorImpl value, $Res Function(_$PaymentErrorImpl) then) =
      __$$PaymentErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, List<PaymentCard>? cards});
}

/// @nodoc
class __$$PaymentErrorImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$PaymentErrorImpl>
    implements _$$PaymentErrorImplCopyWith<$Res> {
  __$$PaymentErrorImplCopyWithImpl(
      _$PaymentErrorImpl _value, $Res Function(_$PaymentErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? cards = freezed,
  }) {
    return _then(_$PaymentErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      cards: freezed == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<PaymentCard>?,
    ));
  }
}

/// @nodoc

class _$PaymentErrorImpl implements PaymentError {
  const _$PaymentErrorImpl(
      {required this.message, final List<PaymentCard>? cards})
      : _cards = cards;

  @override
  final String message;
  final List<PaymentCard>? _cards;
  @override
  List<PaymentCard>? get cards {
    final value = _cards;
    if (value == null) return null;
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PaymentState.error(message: $message, cards: $cards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(_cards));

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentErrorImplCopyWith<_$PaymentErrorImpl> get copyWith =>
      __$$PaymentErrorImplCopyWithImpl<_$PaymentErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentCard> cards) loaded,
    required TResult Function(
            PaymentCard card, List<PaymentCard> cards, String message)
        cardAdded,
    required TResult Function(List<PaymentCard> cards, String message)
        cardDeleted,
    required TResult Function(List<PaymentCard> cards, String message)
        defaultCardUpdated,
    required TResult Function(String message, List<PaymentCard>? cards) error,
  }) {
    return error(message, cards);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentCard> cards)? loaded,
    TResult? Function(
            PaymentCard card, List<PaymentCard> cards, String message)?
        cardAdded,
    TResult? Function(List<PaymentCard> cards, String message)? cardDeleted,
    TResult? Function(List<PaymentCard> cards, String message)?
        defaultCardUpdated,
    TResult? Function(String message, List<PaymentCard>? cards)? error,
  }) {
    return error?.call(message, cards);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentCard> cards)? loaded,
    TResult Function(PaymentCard card, List<PaymentCard> cards, String message)?
        cardAdded,
    TResult Function(List<PaymentCard> cards, String message)? cardDeleted,
    TResult Function(List<PaymentCard> cards, String message)?
        defaultCardUpdated,
    TResult Function(String message, List<PaymentCard>? cards)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, cards);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PaymentInitial value) initial,
    required TResult Function(PaymentLoading value) loading,
    required TResult Function(PaymentLoaded value) loaded,
    required TResult Function(CardAdded value) cardAdded,
    required TResult Function(CardDeleted value) cardDeleted,
    required TResult Function(DefaultCardUpdated value) defaultCardUpdated,
    required TResult Function(PaymentError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PaymentInitial value)? initial,
    TResult? Function(PaymentLoading value)? loading,
    TResult? Function(PaymentLoaded value)? loaded,
    TResult? Function(CardAdded value)? cardAdded,
    TResult? Function(CardDeleted value)? cardDeleted,
    TResult? Function(DefaultCardUpdated value)? defaultCardUpdated,
    TResult? Function(PaymentError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PaymentInitial value)? initial,
    TResult Function(PaymentLoading value)? loading,
    TResult Function(PaymentLoaded value)? loaded,
    TResult Function(CardAdded value)? cardAdded,
    TResult Function(CardDeleted value)? cardDeleted,
    TResult Function(DefaultCardUpdated value)? defaultCardUpdated,
    TResult Function(PaymentError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PaymentError implements PaymentState {
  const factory PaymentError(
      {required final String message,
      final List<PaymentCard>? cards}) = _$PaymentErrorImpl;

  String get message;
  List<PaymentCard>? get cards;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentErrorImplCopyWith<_$PaymentErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
