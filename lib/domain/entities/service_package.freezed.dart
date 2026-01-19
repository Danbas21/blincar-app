// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_package.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServicePackage _$ServicePackageFromJson(Map<String, dynamic> json) {
  return _ServicePackage.fromJson(json);
}

/// @nodoc
mixin _$ServicePackage {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<VehicleType> get vehicleTypes => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  bool get isArmored => throw _privateConstructorUsedError;
  bool get includesEscort => throw _privateConstructorUsedError;
  EscortType? get escortType => throw _privateConstructorUsedError;
  double get basePrice => throw _privateConstructorUsedError;
  double get pricePerKm => throw _privateConstructorUsedError;
  double get pricePerHour => throw _privateConstructorUsedError;
  int get minHours => throw _privateConstructorUsedError;
  List<String> get features => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String description,
            List<VehicleType> vehicleTypes,
            int capacity,
            bool isArmored,
            bool includesEscort,
            EscortType? escortType,
            double basePrice,
            double pricePerKm,
            double pricePerHour,
            int minHours,
            List<String> features,
            String? imageUrl)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String name,
            String description,
            List<VehicleType> vehicleTypes,
            int capacity,
            bool isArmored,
            bool includesEscort,
            EscortType? escortType,
            double basePrice,
            double pricePerKm,
            double pricePerHour,
            int minHours,
            List<String> features,
            String? imageUrl)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String description,
            List<VehicleType> vehicleTypes,
            int capacity,
            bool isArmored,
            bool includesEscort,
            EscortType? escortType,
            double basePrice,
            double pricePerKm,
            double pricePerHour,
            int minHours,
            List<String> features,
            String? imageUrl)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ServicePackage value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ServicePackage value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ServicePackage value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this ServicePackage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServicePackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServicePackageCopyWith<ServicePackage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServicePackageCopyWith<$Res> {
  factory $ServicePackageCopyWith(
          ServicePackage value, $Res Function(ServicePackage) then) =
      _$ServicePackageCopyWithImpl<$Res, ServicePackage>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<VehicleType> vehicleTypes,
      int capacity,
      bool isArmored,
      bool includesEscort,
      EscortType? escortType,
      double basePrice,
      double pricePerKm,
      double pricePerHour,
      int minHours,
      List<String> features,
      String? imageUrl});
}

/// @nodoc
class _$ServicePackageCopyWithImpl<$Res, $Val extends ServicePackage>
    implements $ServicePackageCopyWith<$Res> {
  _$ServicePackageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServicePackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? vehicleTypes = null,
    Object? capacity = null,
    Object? isArmored = null,
    Object? includesEscort = null,
    Object? escortType = freezed,
    Object? basePrice = null,
    Object? pricePerKm = null,
    Object? pricePerHour = null,
    Object? minHours = null,
    Object? features = null,
    Object? imageUrl = freezed,
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
      vehicleTypes: null == vehicleTypes
          ? _value.vehicleTypes
          : vehicleTypes // ignore: cast_nullable_to_non_nullable
              as List<VehicleType>,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int,
      isArmored: null == isArmored
          ? _value.isArmored
          : isArmored // ignore: cast_nullable_to_non_nullable
              as bool,
      includesEscort: null == includesEscort
          ? _value.includesEscort
          : includesEscort // ignore: cast_nullable_to_non_nullable
              as bool,
      escortType: freezed == escortType
          ? _value.escortType
          : escortType // ignore: cast_nullable_to_non_nullable
              as EscortType?,
      basePrice: null == basePrice
          ? _value.basePrice
          : basePrice // ignore: cast_nullable_to_non_nullable
              as double,
      pricePerKm: null == pricePerKm
          ? _value.pricePerKm
          : pricePerKm // ignore: cast_nullable_to_non_nullable
              as double,
      pricePerHour: null == pricePerHour
          ? _value.pricePerHour
          : pricePerHour // ignore: cast_nullable_to_non_nullable
              as double,
      minHours: null == minHours
          ? _value.minHours
          : minHours // ignore: cast_nullable_to_non_nullable
              as int,
      features: null == features
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServicePackageImplCopyWith<$Res>
    implements $ServicePackageCopyWith<$Res> {
  factory _$$ServicePackageImplCopyWith(_$ServicePackageImpl value,
          $Res Function(_$ServicePackageImpl) then) =
      __$$ServicePackageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<VehicleType> vehicleTypes,
      int capacity,
      bool isArmored,
      bool includesEscort,
      EscortType? escortType,
      double basePrice,
      double pricePerKm,
      double pricePerHour,
      int minHours,
      List<String> features,
      String? imageUrl});
}

/// @nodoc
class __$$ServicePackageImplCopyWithImpl<$Res>
    extends _$ServicePackageCopyWithImpl<$Res, _$ServicePackageImpl>
    implements _$$ServicePackageImplCopyWith<$Res> {
  __$$ServicePackageImplCopyWithImpl(
      _$ServicePackageImpl _value, $Res Function(_$ServicePackageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServicePackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? vehicleTypes = null,
    Object? capacity = null,
    Object? isArmored = null,
    Object? includesEscort = null,
    Object? escortType = freezed,
    Object? basePrice = null,
    Object? pricePerKm = null,
    Object? pricePerHour = null,
    Object? minHours = null,
    Object? features = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_$ServicePackageImpl(
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
      vehicleTypes: null == vehicleTypes
          ? _value._vehicleTypes
          : vehicleTypes // ignore: cast_nullable_to_non_nullable
              as List<VehicleType>,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int,
      isArmored: null == isArmored
          ? _value.isArmored
          : isArmored // ignore: cast_nullable_to_non_nullable
              as bool,
      includesEscort: null == includesEscort
          ? _value.includesEscort
          : includesEscort // ignore: cast_nullable_to_non_nullable
              as bool,
      escortType: freezed == escortType
          ? _value.escortType
          : escortType // ignore: cast_nullable_to_non_nullable
              as EscortType?,
      basePrice: null == basePrice
          ? _value.basePrice
          : basePrice // ignore: cast_nullable_to_non_nullable
              as double,
      pricePerKm: null == pricePerKm
          ? _value.pricePerKm
          : pricePerKm // ignore: cast_nullable_to_non_nullable
              as double,
      pricePerHour: null == pricePerHour
          ? _value.pricePerHour
          : pricePerHour // ignore: cast_nullable_to_non_nullable
              as double,
      minHours: null == minHours
          ? _value.minHours
          : minHours // ignore: cast_nullable_to_non_nullable
              as int,
      features: null == features
          ? _value._features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServicePackageImpl extends _ServicePackage {
  const _$ServicePackageImpl(
      {required this.id,
      required this.name,
      required this.description,
      required final List<VehicleType> vehicleTypes,
      required this.capacity,
      this.isArmored = false,
      this.includesEscort = false,
      this.escortType,
      required this.basePrice,
      required this.pricePerKm,
      required this.pricePerHour,
      this.minHours = 1,
      final List<String> features = const [],
      this.imageUrl})
      : _vehicleTypes = vehicleTypes,
        _features = features,
        super._();

  factory _$ServicePackageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServicePackageImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  final List<VehicleType> _vehicleTypes;
  @override
  List<VehicleType> get vehicleTypes {
    if (_vehicleTypes is EqualUnmodifiableListView) return _vehicleTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vehicleTypes);
  }

  @override
  final int capacity;
  @override
  @JsonKey()
  final bool isArmored;
  @override
  @JsonKey()
  final bool includesEscort;
  @override
  final EscortType? escortType;
  @override
  final double basePrice;
  @override
  final double pricePerKm;
  @override
  final double pricePerHour;
  @override
  @JsonKey()
  final int minHours;
  final List<String> _features;
  @override
  @JsonKey()
  List<String> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'ServicePackage(id: $id, name: $name, description: $description, vehicleTypes: $vehicleTypes, capacity: $capacity, isArmored: $isArmored, includesEscort: $includesEscort, escortType: $escortType, basePrice: $basePrice, pricePerKm: $pricePerKm, pricePerHour: $pricePerHour, minHours: $minHours, features: $features, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServicePackageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._vehicleTypes, _vehicleTypes) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.isArmored, isArmored) ||
                other.isArmored == isArmored) &&
            (identical(other.includesEscort, includesEscort) ||
                other.includesEscort == includesEscort) &&
            (identical(other.escortType, escortType) ||
                other.escortType == escortType) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.pricePerKm, pricePerKm) ||
                other.pricePerKm == pricePerKm) &&
            (identical(other.pricePerHour, pricePerHour) ||
                other.pricePerHour == pricePerHour) &&
            (identical(other.minHours, minHours) ||
                other.minHours == minHours) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      const DeepCollectionEquality().hash(_vehicleTypes),
      capacity,
      isArmored,
      includesEscort,
      escortType,
      basePrice,
      pricePerKm,
      pricePerHour,
      minHours,
      const DeepCollectionEquality().hash(_features),
      imageUrl);

  /// Create a copy of ServicePackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServicePackageImplCopyWith<_$ServicePackageImpl> get copyWith =>
      __$$ServicePackageImplCopyWithImpl<_$ServicePackageImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String description,
            List<VehicleType> vehicleTypes,
            int capacity,
            bool isArmored,
            bool includesEscort,
            EscortType? escortType,
            double basePrice,
            double pricePerKm,
            double pricePerHour,
            int minHours,
            List<String> features,
            String? imageUrl)
        $default,
  ) {
    return $default(
        id,
        name,
        description,
        vehicleTypes,
        capacity,
        isArmored,
        includesEscort,
        escortType,
        basePrice,
        pricePerKm,
        pricePerHour,
        minHours,
        features,
        imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String name,
            String description,
            List<VehicleType> vehicleTypes,
            int capacity,
            bool isArmored,
            bool includesEscort,
            EscortType? escortType,
            double basePrice,
            double pricePerKm,
            double pricePerHour,
            int minHours,
            List<String> features,
            String? imageUrl)?
        $default,
  ) {
    return $default?.call(
        id,
        name,
        description,
        vehicleTypes,
        capacity,
        isArmored,
        includesEscort,
        escortType,
        basePrice,
        pricePerKm,
        pricePerHour,
        minHours,
        features,
        imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String description,
            List<VehicleType> vehicleTypes,
            int capacity,
            bool isArmored,
            bool includesEscort,
            EscortType? escortType,
            double basePrice,
            double pricePerKm,
            double pricePerHour,
            int minHours,
            List<String> features,
            String? imageUrl)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          id,
          name,
          description,
          vehicleTypes,
          capacity,
          isArmored,
          includesEscort,
          escortType,
          basePrice,
          pricePerKm,
          pricePerHour,
          minHours,
          features,
          imageUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ServicePackage value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ServicePackage value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ServicePackage value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ServicePackageImplToJson(
      this,
    );
  }
}

abstract class _ServicePackage extends ServicePackage {
  const factory _ServicePackage(
      {required final String id,
      required final String name,
      required final String description,
      required final List<VehicleType> vehicleTypes,
      required final int capacity,
      final bool isArmored,
      final bool includesEscort,
      final EscortType? escortType,
      required final double basePrice,
      required final double pricePerKm,
      required final double pricePerHour,
      final int minHours,
      final List<String> features,
      final String? imageUrl}) = _$ServicePackageImpl;
  const _ServicePackage._() : super._();

  factory _ServicePackage.fromJson(Map<String, dynamic> json) =
      _$ServicePackageImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  List<VehicleType> get vehicleTypes;
  @override
  int get capacity;
  @override
  bool get isArmored;
  @override
  bool get includesEscort;
  @override
  EscortType? get escortType;
  @override
  double get basePrice;
  @override
  double get pricePerKm;
  @override
  double get pricePerHour;
  @override
  int get minHours;
  @override
  List<String> get features;
  @override
  String? get imageUrl;

  /// Create a copy of ServicePackage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServicePackageImplCopyWith<_$ServicePackageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
