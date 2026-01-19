// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_request_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TripRequestInitialImpl _$$TripRequestInitialImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TripRequestInitialImpl',
      json,
      ($checkedConvert) {
        final val = _$TripRequestInitialImpl(
          $type: $checkedConvert('type', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {r'$type': 'type'},
    );

Map<String, dynamic> _$$TripRequestInitialImplToJson(
        _$TripRequestInitialImpl instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$TripRequestLoadingImpl _$$TripRequestLoadingImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TripRequestLoadingImpl',
      json,
      ($checkedConvert) {
        final val = _$TripRequestLoadingImpl(
          message: $checkedConvert('message', (v) => v as String?),
          $type: $checkedConvert('type', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {r'$type': 'type'},
    );

Map<String, dynamic> _$$TripRequestLoadingImplToJson(
        _$TripRequestLoadingImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'type': instance.$type,
    };

_$TripRequestCreatedImpl _$$TripRequestCreatedImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TripRequestCreatedImpl',
      json,
      ($checkedConvert) {
        final val = _$TripRequestCreatedImpl(
          $checkedConvert(
              'trip', (v) => TripEntity.fromJson(v as Map<String, dynamic>)),
          $type: $checkedConvert('type', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {r'$type': 'type'},
    );

Map<String, dynamic> _$$TripRequestCreatedImplToJson(
        _$TripRequestCreatedImpl instance) =>
    <String, dynamic>{
      'trip': instance.trip.toJson(),
      'type': instance.$type,
    };

_$ActiveTripLoadedImpl _$$ActiveTripLoadedImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ActiveTripLoadedImpl',
      json,
      ($checkedConvert) {
        final val = _$ActiveTripLoadedImpl(
          $checkedConvert(
              'trip',
              (v) => v == null
                  ? null
                  : TripEntity.fromJson(v as Map<String, dynamic>)),
          $type: $checkedConvert('type', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {r'$type': 'type'},
    );

Map<String, dynamic> _$$ActiveTripLoadedImplToJson(
        _$ActiveTripLoadedImpl instance) =>
    <String, dynamic>{
      'trip': instance.trip?.toJson(),
      'type': instance.$type,
    };

_$TripHistoryLoadedImpl _$$TripHistoryLoadedImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TripHistoryLoadedImpl',
      json,
      ($checkedConvert) {
        final val = _$TripHistoryLoadedImpl(
          $checkedConvert(
              'trips',
              (v) => (v as List<dynamic>)
                  .map((e) => TripEntity.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $type: $checkedConvert('type', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {r'$type': 'type'},
    );

Map<String, dynamic> _$$TripHistoryLoadedImplToJson(
        _$TripHistoryLoadedImpl instance) =>
    <String, dynamic>{
      'trips': instance.trips.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

_$TripUpdatedImpl _$$TripUpdatedImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TripUpdatedImpl',
      json,
      ($checkedConvert) {
        final val = _$TripUpdatedImpl(
          $checkedConvert(
              'trip', (v) => TripEntity.fromJson(v as Map<String, dynamic>)),
          $type: $checkedConvert('type', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {r'$type': 'type'},
    );

Map<String, dynamic> _$$TripUpdatedImplToJson(_$TripUpdatedImpl instance) =>
    <String, dynamic>{
      'trip': instance.trip.toJson(),
      'type': instance.$type,
    };

_$TripRequestErrorImpl _$$TripRequestErrorImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TripRequestErrorImpl',
      json,
      ($checkedConvert) {
        final val = _$TripRequestErrorImpl(
          $checkedConvert('message', (v) => v as String),
          $type: $checkedConvert('type', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {r'$type': 'type'},
    );

Map<String, dynamic> _$$TripRequestErrorImplToJson(
        _$TripRequestErrorImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'type': instance.$type,
    };
