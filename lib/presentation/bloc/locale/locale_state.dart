// lib/presentation/bloc/locale/locale_state.dart

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale_state.freezed.dart';

/// Estado del LocaleBloc
///
/// Usa Freezed para inmutabilidad y copyWith automatico.
///
/// No genera JSON serialization porque Locale no es serializable por defecto.
@Freezed(toJson: false, fromJson: false)
class LocaleState with _$LocaleState {
  const factory LocaleState({
    required Locale locale,
  }) = _LocaleState;
}
