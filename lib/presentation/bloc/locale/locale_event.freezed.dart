// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locale_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocaleEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Locale systemLocale) initialize,
    required TResult Function() loadSaved,
    required TResult Function(Locale locale) change,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Locale systemLocale)? initialize,
    TResult? Function()? loadSaved,
    TResult? Function(Locale locale)? change,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Locale systemLocale)? initialize,
    TResult Function()? loadSaved,
    TResult Function(Locale locale)? change,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeLocale value) initialize,
    required TResult Function(LoadSavedLocale value) loadSaved,
    required TResult Function(ChangeLocale value) change,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeLocale value)? initialize,
    TResult? Function(LoadSavedLocale value)? loadSaved,
    TResult? Function(ChangeLocale value)? change,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeLocale value)? initialize,
    TResult Function(LoadSavedLocale value)? loadSaved,
    TResult Function(ChangeLocale value)? change,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocaleEventCopyWith<$Res> {
  factory $LocaleEventCopyWith(
          LocaleEvent value, $Res Function(LocaleEvent) then) =
      _$LocaleEventCopyWithImpl<$Res, LocaleEvent>;
}

/// @nodoc
class _$LocaleEventCopyWithImpl<$Res, $Val extends LocaleEvent>
    implements $LocaleEventCopyWith<$Res> {
  _$LocaleEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocaleEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitializeLocaleImplCopyWith<$Res> {
  factory _$$InitializeLocaleImplCopyWith(_$InitializeLocaleImpl value,
          $Res Function(_$InitializeLocaleImpl) then) =
      __$$InitializeLocaleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Locale systemLocale});
}

/// @nodoc
class __$$InitializeLocaleImplCopyWithImpl<$Res>
    extends _$LocaleEventCopyWithImpl<$Res, _$InitializeLocaleImpl>
    implements _$$InitializeLocaleImplCopyWith<$Res> {
  __$$InitializeLocaleImplCopyWithImpl(_$InitializeLocaleImpl _value,
      $Res Function(_$InitializeLocaleImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocaleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? systemLocale = null,
  }) {
    return _then(_$InitializeLocaleImpl(
      systemLocale: null == systemLocale
          ? _value.systemLocale
          : systemLocale // ignore: cast_nullable_to_non_nullable
              as Locale,
    ));
  }
}

/// @nodoc

class _$InitializeLocaleImpl implements InitializeLocale {
  const _$InitializeLocaleImpl({required this.systemLocale});

  @override
  final Locale systemLocale;

  @override
  String toString() {
    return 'LocaleEvent.initialize(systemLocale: $systemLocale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitializeLocaleImpl &&
            (identical(other.systemLocale, systemLocale) ||
                other.systemLocale == systemLocale));
  }

  @override
  int get hashCode => Object.hash(runtimeType, systemLocale);

  /// Create a copy of LocaleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitializeLocaleImplCopyWith<_$InitializeLocaleImpl> get copyWith =>
      __$$InitializeLocaleImplCopyWithImpl<_$InitializeLocaleImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Locale systemLocale) initialize,
    required TResult Function() loadSaved,
    required TResult Function(Locale locale) change,
  }) {
    return initialize(systemLocale);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Locale systemLocale)? initialize,
    TResult? Function()? loadSaved,
    TResult? Function(Locale locale)? change,
  }) {
    return initialize?.call(systemLocale);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Locale systemLocale)? initialize,
    TResult Function()? loadSaved,
    TResult Function(Locale locale)? change,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(systemLocale);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeLocale value) initialize,
    required TResult Function(LoadSavedLocale value) loadSaved,
    required TResult Function(ChangeLocale value) change,
  }) {
    return initialize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeLocale value)? initialize,
    TResult? Function(LoadSavedLocale value)? loadSaved,
    TResult? Function(ChangeLocale value)? change,
  }) {
    return initialize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeLocale value)? initialize,
    TResult Function(LoadSavedLocale value)? loadSaved,
    TResult Function(ChangeLocale value)? change,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(this);
    }
    return orElse();
  }
}

abstract class InitializeLocale implements LocaleEvent {
  const factory InitializeLocale({required final Locale systemLocale}) =
      _$InitializeLocaleImpl;

  Locale get systemLocale;

  /// Create a copy of LocaleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitializeLocaleImplCopyWith<_$InitializeLocaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadSavedLocaleImplCopyWith<$Res> {
  factory _$$LoadSavedLocaleImplCopyWith(_$LoadSavedLocaleImpl value,
          $Res Function(_$LoadSavedLocaleImpl) then) =
      __$$LoadSavedLocaleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadSavedLocaleImplCopyWithImpl<$Res>
    extends _$LocaleEventCopyWithImpl<$Res, _$LoadSavedLocaleImpl>
    implements _$$LoadSavedLocaleImplCopyWith<$Res> {
  __$$LoadSavedLocaleImplCopyWithImpl(
      _$LoadSavedLocaleImpl _value, $Res Function(_$LoadSavedLocaleImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocaleEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadSavedLocaleImpl implements LoadSavedLocale {
  const _$LoadSavedLocaleImpl();

  @override
  String toString() {
    return 'LocaleEvent.loadSaved()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadSavedLocaleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Locale systemLocale) initialize,
    required TResult Function() loadSaved,
    required TResult Function(Locale locale) change,
  }) {
    return loadSaved();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Locale systemLocale)? initialize,
    TResult? Function()? loadSaved,
    TResult? Function(Locale locale)? change,
  }) {
    return loadSaved?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Locale systemLocale)? initialize,
    TResult Function()? loadSaved,
    TResult Function(Locale locale)? change,
    required TResult orElse(),
  }) {
    if (loadSaved != null) {
      return loadSaved();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeLocale value) initialize,
    required TResult Function(LoadSavedLocale value) loadSaved,
    required TResult Function(ChangeLocale value) change,
  }) {
    return loadSaved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeLocale value)? initialize,
    TResult? Function(LoadSavedLocale value)? loadSaved,
    TResult? Function(ChangeLocale value)? change,
  }) {
    return loadSaved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeLocale value)? initialize,
    TResult Function(LoadSavedLocale value)? loadSaved,
    TResult Function(ChangeLocale value)? change,
    required TResult orElse(),
  }) {
    if (loadSaved != null) {
      return loadSaved(this);
    }
    return orElse();
  }
}

abstract class LoadSavedLocale implements LocaleEvent {
  const factory LoadSavedLocale() = _$LoadSavedLocaleImpl;
}

/// @nodoc
abstract class _$$ChangeLocaleImplCopyWith<$Res> {
  factory _$$ChangeLocaleImplCopyWith(
          _$ChangeLocaleImpl value, $Res Function(_$ChangeLocaleImpl) then) =
      __$$ChangeLocaleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Locale locale});
}

/// @nodoc
class __$$ChangeLocaleImplCopyWithImpl<$Res>
    extends _$LocaleEventCopyWithImpl<$Res, _$ChangeLocaleImpl>
    implements _$$ChangeLocaleImplCopyWith<$Res> {
  __$$ChangeLocaleImplCopyWithImpl(
      _$ChangeLocaleImpl _value, $Res Function(_$ChangeLocaleImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocaleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locale = null,
  }) {
    return _then(_$ChangeLocaleImpl(
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
    ));
  }
}

/// @nodoc

class _$ChangeLocaleImpl implements ChangeLocale {
  const _$ChangeLocaleImpl({required this.locale});

  @override
  final Locale locale;

  @override
  String toString() {
    return 'LocaleEvent.change(locale: $locale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeLocaleImpl &&
            (identical(other.locale, locale) || other.locale == locale));
  }

  @override
  int get hashCode => Object.hash(runtimeType, locale);

  /// Create a copy of LocaleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeLocaleImplCopyWith<_$ChangeLocaleImpl> get copyWith =>
      __$$ChangeLocaleImplCopyWithImpl<_$ChangeLocaleImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Locale systemLocale) initialize,
    required TResult Function() loadSaved,
    required TResult Function(Locale locale) change,
  }) {
    return change(locale);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Locale systemLocale)? initialize,
    TResult? Function()? loadSaved,
    TResult? Function(Locale locale)? change,
  }) {
    return change?.call(locale);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Locale systemLocale)? initialize,
    TResult Function()? loadSaved,
    TResult Function(Locale locale)? change,
    required TResult orElse(),
  }) {
    if (change != null) {
      return change(locale);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeLocale value) initialize,
    required TResult Function(LoadSavedLocale value) loadSaved,
    required TResult Function(ChangeLocale value) change,
  }) {
    return change(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeLocale value)? initialize,
    TResult? Function(LoadSavedLocale value)? loadSaved,
    TResult? Function(ChangeLocale value)? change,
  }) {
    return change?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeLocale value)? initialize,
    TResult Function(LoadSavedLocale value)? loadSaved,
    TResult Function(ChangeLocale value)? change,
    required TResult orElse(),
  }) {
    if (change != null) {
      return change(this);
    }
    return orElse();
  }
}

abstract class ChangeLocale implements LocaleEvent {
  const factory ChangeLocale({required final Locale locale}) =
      _$ChangeLocaleImpl;

  Locale get locale;

  /// Create a copy of LocaleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeLocaleImplCopyWith<_$ChangeLocaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
