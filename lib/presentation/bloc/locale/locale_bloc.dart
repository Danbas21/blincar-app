// lib/presentation/bloc/locale/locale_bloc.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/storage_service.dart';
import 'locale_event.dart';
import 'locale_state.dart';

/// BLoC para manejar el idioma de la aplicación
///
/// Funcionalidades:
/// - Detecta el idioma del sistema al iniciar
/// - Carga el idioma guardado en SharedPreferences
/// - Permite cambiar el idioma manualmente
/// - Persiste la preferencia del usuario
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final StorageService storageService;

  /// Idiomas soportados por la aplicación
  static const List<Locale> supportedLocales = [
    Locale('es', 'MX'), // Español (México)
    Locale('en', 'US'), // Inglés (Estados Unidos)
  ];

  /// Idioma por defecto
  static const Locale defaultLocale = Locale('es', 'MX');

  LocaleBloc(this.storageService)
      : super(const LocaleState(locale: Locale('es', 'MX'))) {
    on<InitializeLocale>(_onInitializeLocale);
    on<LoadSavedLocale>(_onLoadSavedLocale);
    on<ChangeLocale>(_onChangeLocale);
  }

  /// Inicializa el idioma basándose en:
  /// 1. Preferencia guardada del usuario
  /// 2. Idioma del sistema (si está soportado)
  /// 3. Idioma por defecto (español)
  Future<void> _onInitializeLocale(
    InitializeLocale event,
    Emitter<LocaleState> emit,
  ) async {
    // 1. Intentar cargar idioma guardado
    final savedLocale = storageService.getLocale();

    if (savedLocale != null && savedLocale.isNotEmpty) {
      // Usuario ya eligió un idioma previamente
      final locale = _parseLocale(savedLocale);
      emit(LocaleState(locale: locale));
      return;
    }

    // 2. Usar idioma del sistema si está soportado
    final systemLocale = event.systemLocale;
    final matchingLocale = _findMatchingLocale(systemLocale);

    if (matchingLocale != null) {
      // Guardar el idioma del sistema como preferencia inicial
      await storageService.saveLocale(matchingLocale.toString());
      emit(LocaleState(locale: matchingLocale));
      return;
    }

    // 3. Usar idioma por defecto
    await storageService.saveLocale(defaultLocale.toString());
    emit(LocaleState(locale: defaultLocale));
  }

  /// Carga el idioma guardado (para compatibilidad)
  Future<void> _onLoadSavedLocale(
    LoadSavedLocale event,
    Emitter<LocaleState> emit,
  ) async {
    final savedLocale = storageService.getLocale();

    if (savedLocale != null && savedLocale.isNotEmpty) {
      final locale = _parseLocale(savedLocale);
      emit(LocaleState(locale: locale));
    }
  }

  /// Cambia el idioma y lo guarda en preferencias
  Future<void> _onChangeLocale(
    ChangeLocale event,
    Emitter<LocaleState> emit,
  ) async {
    await storageService.saveLocale(event.locale.toString());
    emit(LocaleState(locale: event.locale));
  }

  /// Parsea un string de locale a objeto Locale
  Locale _parseLocale(String localeString) {
    final parts = localeString.split('_');
    if (parts.length == 2) {
      return Locale(parts[0], parts[1]);
    }
    // Intentar con solo el código de idioma
    if (parts.isNotEmpty) {
      return _findMatchingLocale(Locale(parts[0])) ?? defaultLocale;
    }
    return defaultLocale;
  }

  /// Encuentra un locale soportado que coincida con el sistema
  Locale? _findMatchingLocale(Locale systemLocale) {
    // Buscar coincidencia exacta (idioma + país)
    for (final supported in supportedLocales) {
      if (supported.languageCode == systemLocale.languageCode &&
          supported.countryCode == systemLocale.countryCode) {
        return supported;
      }
    }

    // Buscar coincidencia solo por idioma
    for (final supported in supportedLocales) {
      if (supported.languageCode == systemLocale.languageCode) {
        return supported;
      }
    }

    return null;
  }

  /// Obtiene el nombre del idioma para mostrar
  static String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'es':
        return 'Español';
      case 'en':
        return 'English';
      default:
        return locale.languageCode;
    }
  }

  /// Obtiene el nombre nativo del idioma
  static String getLanguageNativeName(Locale locale) {
    switch (locale.languageCode) {
      case 'es':
        return 'Español';
      case 'en':
        return 'English';
      default:
        return locale.languageCode;
    }
  }

  /// Obtiene el código de bandera emoji para el idioma
  static String getLanguageFlag(Locale locale) {
    switch (locale.countryCode) {
      case 'MX':
        return '\u{1F1F2}\u{1F1FD}'; // 🇲🇽
      case 'US':
        return '\u{1F1FA}\u{1F1F8}'; // 🇺🇸
      case 'ES':
        return '\u{1F1EA}\u{1F1F8}'; // 🇪🇸
      case 'GB':
        return '\u{1F1EC}\u{1F1E7}'; // 🇬🇧
      default:
        return '\u{1F310}'; // 🌐
    }
  }
}
