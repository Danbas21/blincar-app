// lib/presentation/bloc/locale/locale_event.dart

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale_event.freezed.dart';

/// Eventos del LocaleBloc
///
/// Usa sealed class pattern con Freezed para type-safety
/// y pattern matching exhaustivo.
///
/// No genera JSON serialization porque Locale no es serializable por defecto.
@Freezed(toJson: false, fromJson: false)
sealed class LocaleEvent with _$LocaleEvent {
  /// Evento para inicializar el idioma
  ///
  /// Prioridad:
  /// 1. Idioma guardado en SharedPreferences
  /// 2. Idioma del dispositivo (si está soportado)
  /// 3. Español como fallback
  const factory LocaleEvent.initialize({
    required Locale systemLocale,
  }) = InitializeLocale;

  /// Evento para cargar el idioma guardado en preferencias (legacy)
  const factory LocaleEvent.loadSaved() = LoadSavedLocale;

  /// Evento para cambiar el idioma de la aplicacion
  const factory LocaleEvent.change({
    required Locale locale,
  }) = ChangeLocale;
}
