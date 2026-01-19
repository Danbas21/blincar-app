// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServiceType _$ServiceTypeFromJson(Map<String, dynamic> json) {
  return _ServiceType.fromJson(json);
}

/// @nodoc
mixin _$ServiceType {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get basePrice => throw _privateConstructorUsedError;
  double get pricePerKm => throw _privateConstructorUsedError;
  double get pricePerMinute => throw _privateConstructorUsedError;
  double get pricePerHour => throw _privateConstructorUsedError;
  double get pricePerDay => throw _privateConstructorUsedError;
  double get commissionPercentage => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get requiresSpecialLicense => throw _privateConstructorUsedError;
  String get region => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String description,
            double basePrice,
            double pricePerKm,
            double pricePerMinute,
            double pricePerHour,
            double pricePerDay,
            double commissionPercentage,
            bool isActive,
            bool requiresSpecialLicense,
            String region,
            String currency)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String name,
            String description,
            double basePrice,
            double pricePerKm,
            double pricePerMinute,
            double pricePerHour,
            double pricePerDay,
            double commissionPercentage,
            bool isActive,
            bool requiresSpecialLicense,
            String region,
            String currency)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String description,
            double basePrice,
            double pricePerKm,
            double pricePerMinute,
            double pricePerHour,
            double pricePerDay,
            double commissionPercentage,
            bool isActive,
            bool requiresSpecialLicense,
            String region,
            String currency)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ServiceType value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ServiceType value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ServiceType value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this ServiceType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceTypeCopyWith<ServiceType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceTypeCopyWith<$Res> {
  factory $ServiceTypeCopyWith(
          ServiceType value, $Res Function(ServiceType) then) =
      _$ServiceTypeCopyWithImpl<$Res, ServiceType>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      double basePrice,
      double pricePerKm,
      double pricePerMinute,
      double pricePerHour,
      double pricePerDay,
      double commissionPercentage,
      bool isActive,
      bool requiresSpecialLicense,
      String region,
      String currency});
}

/// @nodoc
class _$ServiceTypeCopyWithImpl<$Res, $Val extends ServiceType>
    implements $ServiceTypeCopyWith<$Res> {
  _$ServiceTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? basePrice = null,
    Object? pricePerKm = null,
    Object? pricePerMinute = null,
    Object? pricePerHour = null,
    Object? pricePerDay = null,
    Object? commissionPercentage = null,
    Object? isActive = null,
    Object? requiresSpecialLicense = null,
    Object? region = null,
    Object? currency = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      basePrice: null == basePrice
          ? _value.basePrice
          : basePrice // ignore: cast_nullable_to_non_nullable
              as double,
      pricePerKm: null == pricePerKm
          ? _value.pricePerKm
          : pricePerKm // ignore: cast_nullable_to_non_nullable
              as double,
      pricePerMinute: null == pricePerMinute
          ? _value.pricePerMinute
          : pricePerMinute // ignore: cast_nullable_to_non_nullable
              as double,
      pricePerHour: null == pricePerHour
          ? _value.pricePerHour
          : pricePerHour // ignore: cast_nullable_to_non_nullable
              as double,
      pricePerDay: null == pricePerDay
          ? _value.pricePerDay
          : pricePerDay // ignore: cast_nullable_to_non_nullable
              as double,
      commissionPercentage: null == commissionPercentage
          ? _value.commissionPercentage
          : commissionPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      requiresSpecialLicense: null == requiresSpecialLicense
          ? _value.requiresSpecialLicense
          : requiresSpecialLicense // ignore: cast_nullable_to_non_nullable
              as bool,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceTypeImplCopyWith<$Res>
    implements $ServiceTypeCopyWith<$Res> {
  factory _$$ServiceTypeImplCopyWith(
          _$ServiceTypeImpl value, $Res Function(_$ServiceTypeImpl) then) =
      __$$ServiceTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      double basePrice,
      double pricePerKm,
      double pricePerMinute,
      double pricePerHour,
      double pricePerDay,
      double commissionPercentage,
      bool isActive,
      bool requiresSpecialLicense,
      String region,
      String currency});
}

/// @nodoc
class __$$ServiceTypeImplCopyWithImpl<$Res>
    extends _$ServiceTypeCopyWithImpl<$Res, _$ServiceTypeImpl>
    implements _$$ServiceTypeImplCopyWith<$Res> {
  __$$ServiceTypeImplCopyWithImpl(
      _$ServiceTypeImpl _value, $Res Function(_$ServiceTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? basePrice = null,
    Object? pricePerKm = null,
    Object? pricePerMinute = null,
    Object? pricePerHour = null,
    Object? pricePerDay = null,
    Object? commissionPercentage = null,
    Object? isActive = null,
    Object? requiresSpecialLicense = null,
    Object? region = null,
    Object? currency = null,
  }) {
    return _then(_$ServiceTypeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      basePrice: null == basePrice
          ? _value.basePrice
          : basePrice // ignore: cast_nullable_to_non_nullable
              as double,
      pricePerKm: null == pricePerKm
          ? _value.pricePerKm
          : pricePerKm // ignore: cast_nullable_to_non_nullable
              as double,
      pricePerMinute: null == pricePerMinute
          ? _value.pricePerMinute
          : pricePerMinute // ignore: cast_nullable_to_non_nullable
              as double,
      pricePerHour: null == pricePerHour
          ? _value.pricePerHour
          : pricePerHour // ignore: cast_nullable_to_non_nullable
              as double,
      pricePerDay: null == pricePerDay
          ? _value.pricePerDay
          : pricePerDay // ignore: cast_nullable_to_non_nullable
              as double,
      commissionPercentage: null == commissionPercentage
          ? _value.commissionPercentage
          : commissionPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      requiresSpecialLicense: null == requiresSpecialLicense
          ? _value.requiresSpecialLicense
          : requiresSpecialLicense // ignore: cast_nullable_to_non_nullable
              as bool,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceTypeImpl extends _ServiceType {
  const _$ServiceTypeImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.basePrice,
      this.pricePerKm = 0.0,
      this.pricePerMinute = 0.0,
      this.pricePerHour = 0.0,
      this.pricePerDay = 0.0,
      this.commissionPercentage = 15.0,
      this.isActive = true,
      this.requiresSpecialLicense = false,
      this.region = 'mx',
      this.currency = 'MXN'})
      : super._();

  factory _$ServiceTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceTypeImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final double basePrice;
  @override
  @JsonKey()
  final double pricePerKm;
  @override
  @JsonKey()
  final double pricePerMinute;
  @override
  @JsonKey()
  final double pricePerHour;
  @override
  @JsonKey()
  final double pricePerDay;
  @override
  @JsonKey()
  final double commissionPercentage;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool requiresSpecialLicense;
  @override
  @JsonKey()
  final String region;
  @override
  @JsonKey()
  final String currency;

  @override
  String toString() {
    return 'ServiceType(id: $id, name: $name, description: $description, basePrice: $basePrice, pricePerKm: $pricePerKm, pricePerMinute: $pricePerMinute, pricePerHour: $pricePerHour, pricePerDay: $pricePerDay, commissionPercentage: $commissionPercentage, isActive: $isActive, requiresSpecialLicense: $requiresSpecialLicense, region: $region, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.pricePerKm, pricePerKm) ||
                other.pricePerKm == pricePerKm) &&
            (identical(other.pricePerMinute, pricePerMinute) ||
                other.pricePerMinute == pricePerMinute) &&
            (identical(other.pricePerHour, pricePerHour) ||
                other.pricePerHour == pricePerHour) &&
            (identical(other.pricePerDay, pricePerDay) ||
                other.pricePerDay == pricePerDay) &&
            (identical(other.commissionPercentage, commissionPercentage) ||
                other.commissionPercentage == commissionPercentage) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.requiresSpecialLicense, requiresSpecialLicense) ||
                other.requiresSpecialLicense == requiresSpecialLicense) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      basePrice,
      pricePerKm,
      pricePerMinute,
      pricePerHour,
      pricePerDay,
      commissionPercentage,
      isActive,
      requiresSpecialLicense,
      region,
      currency);

  /// Create a copy of ServiceType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceTypeImplCopyWith<_$ServiceTypeImpl> get copyWith =>
      __$$ServiceTypeImplCopyWithImpl<_$ServiceTypeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String description,
            double basePrice,
            double pricePerKm,
            double pricePerMinute,
            double pricePerHour,
            double pricePerDay,
            double commissionPercentage,
            bool isActive,
            bool requiresSpecialLicense,
            String region,
            String currency)
        $default,
  ) {
    return $default(
        id,
        name,
        description,
        basePrice,
        pricePerKm,
        pricePerMinute,
        pricePerHour,
        pricePerDay,
        commissionPercentage,
        isActive,
        requiresSpecialLicense,
        region,
        currency);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String name,
            String description,
            double basePrice,
            double pricePerKm,
            double pricePerMinute,
            double pricePerHour,
            double pricePerDay,
            double commissionPercentage,
            bool isActive,
            bool requiresSpecialLicense,
            String region,
            String currency)?
        $default,
  ) {
    return $default?.call(
        id,
        name,
        description,
        basePrice,
        pricePerKm,
        pricePerMinute,
        pricePerHour,
        pricePerDay,
        commissionPercentage,
        isActive,
        requiresSpecialLicense,
        region,
        currency);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String description,
            double basePrice,
            double pricePerKm,
            double pricePerMinute,
            double pricePerHour,
            double pricePerDay,
            double commissionPercentage,
            bool isActive,
            bool requiresSpecialLicense,
            String region,
            String currency)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          id,
          name,
          description,
          basePrice,
          pricePerKm,
          pricePerMinute,
          pricePerHour,
          pricePerDay,
          commissionPercentage,
          isActive,
          requiresSpecialLicense,
          region,
          currency);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ServiceType value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ServiceType value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ServiceType value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceTypeImplToJson(
      this,
    );
  }
}

abstract class _ServiceType extends ServiceType {
  const factory _ServiceType(
      {required final String id,
      required final String name,
      required final String description,
      required final double basePrice,
      final double pricePerKm,
      final double pricePerMinute,
      final double pricePerHour,
      final double pricePerDay,
      final double commissionPercentage,
      final bool isActive,
      final bool requiresSpecialLicense,
      final String region,
      final String currency}) = _$ServiceTypeImpl;
  const _ServiceType._() : super._();

  factory _ServiceType.fromJson(Map<String, dynamic> json) =
      _$ServiceTypeImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  double get basePrice;
  @override
  double get pricePerKm;
  @override
  double get pricePerMinute;
  @override
  double get pricePerHour;
  @override
  double get pricePerDay;
  @override
  double get commissionPercentage;
  @override
  bool get isActive;
  @override
  bool get requiresSpecialLicense;
  @override
  String get region;
  @override
  String get currency;

  /// Create a copy of ServiceType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceTypeImplCopyWith<_$ServiceTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
