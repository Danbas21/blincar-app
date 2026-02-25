# CLAUDE.md - Blincar App (User App)

## Proyecto

**Blincar** es una app de transporte ejecutivo premium con seguridad de alto nivel.
Este directorio contiene la **User App (pasajero)** + **Monitor Mode (despachador)**.

- **Version:** 1.0.1+7 (Alpha 7)
- **Estado:** User App 100% - Alpha cerrada en Play Store (en revisión)
- **Firebase Project:** `blin-car1`

## Ecosistema Completo

```
D:\appsBoomerang\blincar-app-project\
├── frontend-flutter/
│   ├── blincar_app/          # <-- ESTAMOS AQUI (User App + Monitor)
│   └── blincar_driver/       # Driver App (95%)
├── backend-api/              # Node.js + Express + Stripe (100%)
├── admin-panel/              # Django (80%)
├── docs/info_claude/         # Documentacion detallada del proyecto
└── legal-pages/              # Firebase Hosting
```

## Arquitectura

- **Clean Architecture** + **BLoC Pattern**
- Capas: `presentation/ → domain/ → data/`
- Modelos inmutables con **Freezed**
- Inyeccion de dependencias con **GetIt**
- Manejo de errores funcional con **dartz (Either)**

### Entry Points

| Archivo | Rol | Comando |
|---------|-----|---------|
| `main.dart` | Pasajero | `flutter run` |
| `main_monitor.dart` | Despachador | `flutter run -t lib/main_monitor.dart` |

## Comandos Frecuentes

```bash
# Ejecutar app
flutter run

# Analizar codigo
flutter analyze

# Generar codigo Freezed
dart run build_runner build --delete-conflicting-outputs

# Build release
flutter clean && flutter pub get && flutter build appbundle --release

# Tests
flutter test

# Deploy Cloud Functions
cd docs/functions && npm run build && firebase deploy --only functions
```

## Stack Tecnologico

- Flutter 3.0+ / Dart 3.0+
- Firebase: Auth, Realtime DB, Storage, FCM, Functions v2
- Google Maps Flutter
- Stripe (produccion, via backend-api)
- flutter_bloc 8.1.6, freezed 2.5.2, get_it 7.6.9, dartz 0.10.1

## Estructura de Directorios Clave

```
lib/
├── core/
│   ├── constants/routes_data.dart    # Rutas predefinidas AICM
│   ├── services/service_locator.dart # GetIt DI
│   ├── theme/app_theme.dart          # Tema oscuro azul
│   └── errors/failures.dart          # Tipos de Failure
├── domain/
│   ├── entities/                     # User, Driver, Vehicle, TripEntity
│   ├── repositories/                 # Interfaces abstractas (SOLID ISP)
│   └── usecases/                     # LoginUseCase, CreateTripRequest, etc.
├── data/
│   ├── repositories/                 # FirebaseAuthRepo, FirebaseTripRepo
│   └── models/
└── presentation/
    ├── bloc/auth/                    # AuthBloc (login, register, logout)
    ├── bloc/trip/                    # TripRequestBloc
    ├── pages/                        # UI pages organizadas por feature
    └── widgets/common/               # CustomButton, CustomTextField
```

## Convenciones

- **Idioma UI:** Espanol (es_MX) + Ingles (en) — i18n completo implementado (Sprint 8.5)
- **Formato moneda:** `NumberFormat.currency(locale: 'es_MX', symbol: '\$', decimalDigits: 2)`
- **BLoC Events/States:** Siempre usar `@freezed sealed class`
- **Repositories:** Domain define interfaces abstractas, Data las implementa
- **Errores:** Retornar `Either<Failure, T>`, nunca lanzar excepciones
- **No hacer git commit** automaticamente - esperar instruccion del usuario

## Firebase Realtime Database

Raiz: `/blincar/`
- `/users/{userId}/` - Datos del pasajero
- `/drivers/{driverId}/` - Datos del conductor
- `/vehicles/{vehicleId}/` - Vehiculos
- `/trips/{tripId}/` - Viajes (status: pending→assigned→driver_arrived→in_progress→completed→cancelled)
- `/tripRequests/pending/` - Indice viajes pendientes
- `/chats/{tripId}/messages/` - Chat en tiempo real
- `/ratings/{tripId}/` - Calificaciones bidireccionales
- `/panic_alerts/{alertId}/` - Alertas de panico
- `/notifications/{userId}/` - Notificaciones

## Cloud Functions (docs/functions/src/index.ts)

| Funcion | Trigger | Descripcion |
|---------|---------|-------------|
| `onTripStatusChanged` | RTDB onUpdate | Push cuando cambia status del viaje |
| `notifyDriverNearby` | RTDB onUpdate | Push cuando conductor < 200m |
| `sendPasswordResetEmail` | HTTPS Callable | Reset password |
| `onNewTripCreated` | RTDB onCreate | Notifica conductores disponibles |
| `onChatMessage` | RTDB onCreate | Notifica receptor del chat |

## Pagos

Todo el sistema de pagos corre en **backend-api** (Node.js + Stripe PRODUCCION).
El archivo `payments.ts.disabled` en Cloud Functions NO SE USA.

## i18n - Internacionalizacion

- **Idiomas:** es_MX (default) + en
- **Archivos ARB:** `lib/l10n/app_es.arb`, `lib/l10n/app_en.arb`
- **Config:** `l10n.yaml` con `output-dir: lib/l10n`, `synthetic-package: false`
- **Generacion:** `flutter gen-l10n` → genera `lib/l10n/app_localizations.dart`
- **Import correcto:** `package:blincar_app/l10n/app_localizations.dart`
- **Cambio de idioma:** `LocaleBloc` (BLoC) + `SharedPreferences` via `StorageService`
- **MaterialApp:** envuelto en `BlocBuilder<LocaleBloc, LocaleState>` con `locale: localeState.locale`
- **~220 keys** cubriendo todas las pantallas de la User App
- **IMPORTANTE:** Cuando se agrega una key nueva a `app_es.arb`, siempre agregarla tambien a `app_en.arb`

```bash
# Regenerar archivos l10n tras cambios en ARB
flutter gen-l10n
```

## Documentacion Detallada

Para contexto mas profundo, consultar:
- `D:\appsBoomerang\blincar-app-project\docs\info_claude\CONTEXTO_DESARROLLO.md`
- `D:\appsBoomerang\blincar-app-project\docs\info_claude\INVENTARIO_BLINCAR_COMPLETO.md`
- `D:\appsBoomerang\blincar-app-project\docs\info_claude\SKILL_ARQUITECTURA_BLINCAR.md`
- `D:\appsBoomerang\blincar-app-project\docs\info_claude\PLAN_SPRINT_8.md`
