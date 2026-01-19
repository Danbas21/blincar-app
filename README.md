# Blincar - Aplicacion de Transporte Premium con Seguridad

Blincar es una aplicacion de transporte y movilidad premium con enfoque en **seguridad de alto nivel**. La plataforma funciona como un ecosistema de multiples roles que incluye pasajeros, conductores y monitores/dispatchers.

## Tabla de Contenidos

- [Descripcion General](#descripcion-general)
- [Caracteristicas Principales](#caracteristicas-principales)
- [Arquitectura](#arquitectura)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Configuracion e Instalacion](#configuracion-e-instalacion)
- [Modelos de Datos](#modelos-de-datos)
- [Servicios y Repositorios](#servicios-y-repositorios)
- [Pantallas Principales](#pantallas-principales)
- [Firebase Integration](#firebase-integration)
- [Tema y Diseno](#tema-y-diseno)
- [Internacionalizacion](#internacionalizacion)
- [Dependencias](#dependencias)

---

## Descripcion General

Blincar es una plataforma de transporte ejecutivo que ofrece:

- **Aplicacion del Usuario/Pasajero**: Solicita viajes seguros, rastreo en tiempo real, grabacion de video, boton de panico
- **Aplicacion del Conductor**: Recibe solicitudes, acepta viajes, transmite video en vivo (Hikvision RTSP)
- **Aplicacion del Monitor/Dispatcher**: Dashboard para gestionar viajes, asignar conductores, supervisar flota

### Puntos de Entrada

| Archivo | Descripcion |
|---------|-------------|
| `lib/main.dart` | Entry point para pasajeros |
| `lib/main_driver.dart` | Entry point para conductores |
| `lib/main_monitor.dart` | Entry point para monitores/dispatchers |

---

## Caracteristicas Principales

### Seguridad
- **Boton de Panico**: Cuenta regresiva de 5 segundos con vibracion y alerta a contactos de emergencia
- **Grabacion de Video**: Streaming RTSP desde camaras Hikvision del vehiculo
- **Rastreo GPS en Tiempo Real**: Actualizacion cada 10 metros o 10 segundos
- **Vehiculos Blindados**: Soporte para diferentes niveles de blindaje

### Funcionalidades
- Autenticacion con Firebase (email/password)
- Solicitud y rastreo de viajes en tiempo real
- Sistema de calificaciones y resenas
- Historial completo de viajes
- Soporte multi-idioma (Espanol/Ingles)
- Tema oscuro personalizado

---

## Arquitectura

El proyecto implementa **Clean Architecture** con el patron **BLoC** para gestion de estado.

```
+-----------------------------------------------------+
|                  PRESENTATION                        |
|  (Pages, Widgets, BLoCs)                            |
+-----------------------------------------------------+
|                    DOMAIN                            |
|  (Entities, Repositories Abstracts, Use Cases)      |
+-----------------------------------------------------+
|                     DATA                             |
|  (Models, Repository Implementations, DataSources)  |
+-----------------------------------------------------+
```

### Patrones Implementados

| Patron | Uso |
|--------|-----|
| **BLoC** | Gestion de estado (AuthBloc, TripRequestBloc, LocaleBloc, VideoStreamBloc) |
| **Repository** | Abstraccion de fuentes de datos |
| **Use Cases** | Logica de aplicacion especifica |
| **Service Locator** | Inyeccion de dependencias con GetIt |
| **Freezed** | Modelos inmutables con generacion de codigo |
| **Either (dartz)** | Manejo funcional de errores |

---

## Estructura del Proyecto

```
lib/
├── main.dart                    # Entry point (Pasajero)
├── main_driver.dart             # Entry point (Conductor)
├── main_monitor.dart            # Entry point (Monitor)
├── firebase_options.dart        # Configuracion Firebase
│
├── core/
│   ├── constants/
│   │   ├── app_constants.dart   # Constantes generales
│   │   ├── api_constants.dart   # URLs y endpoints
│   │   ├── camera_constants.dart # Config. camara RTSP
│   │   ├── images_constant.dart # Rutas de assets
│   │   └── routes_data.dart     # Rutas predefinidas (AICM, Polanco, etc.)
│   │
│   ├── services/
│   │   ├── service_locator.dart # Inyeccion de dependencias
│   │   ├── api_service.dart     # Cliente HTTP (Dio)
│   │   ├── storage_service.dart # SharedPreferences
│   │   ├── location_service.dart # GPS/Geolocalizacion
│   │   └── location_tracking_service.dart
│   │
│   ├── theme/
│   │   └── app_theme.dart       # Tema Material Design
│   │
│   ├── utils/
│   │   └── validators.dart      # Validaciones
│   │
│   └── errors/
│       ├── failures.dart        # Clases de errores
│       └── exceptions.dart      # Excepciones
│
├── domain/
│   ├── entities/
│   │   ├── user.dart            # Usuario (@freezed)
│   │   ├── driver.dart          # Conductor
│   │   ├── vehicle.dart         # Vehiculo
│   │   ├── service_type.dart    # Tipos de servicio
│   │   ├── service_package.dart # Paquetes
│   │   ├── trip.dart            # Viaje
│   │   ├── active_trip.dart     # Viaje activo
│   │   ├── trip_request.dart    # Solicitud de viaje
│   │   └── trip/
│   │       ├── trip_entity.dart # @freezed
│   │       └── route_entity.dart
│   │
│   ├── repositories/
│   │   ├── auth_repository.dart
│   │   ├── trip_repository.dart
│   │   └── video_stream_repository.dart
│   │
│   ├── usecases/
│   │   ├── auth/
│   │   │   ├── login_usecase.dart
│   │   │   └── register_usecase.dart
│   │   └── trip/
│   │       ├── create_trip_request_usecase.dart
│   │       ├── get_trip_by_id_usecase.dart
│   │       └── watch_trip_usecase.dart
│   │
│   └── value_objects/
│       ├── coordinates.dart
│       └── location.dart
│
├── data/
│   ├── models/
│   │   ├── trip_model.dart
│   │   └── service_type_model.dart
│   │
│   ├── repositories/
│   │   ├── firebase_auth_repository.dart
│   │   ├── firebase_trip_repository.dart
│   │   ├── phone_camera_video_repository.dart
│   │   └── firebase_video_storage_repository.dart
│   │
│   └── mock/
│       └── mock_data.dart
│
├── presentation/
│   ├── bloc/
│   │   ├── auth/
│   │   │   ├── auth_bloc.dart
│   │   │   ├── auth_event.dart
│   │   │   └── auth_state.dart
│   │   ├── locale/
│   │   ├── trip/
│   │   └── video/
│   │
│   ├── pages/
│   │   ├── splash/
│   │   ├── auth/
│   │   ├── home/
│   │   ├── trip/
│   │   ├── profile/
│   │   ├── panic/
│   │   ├── driver/
│   │   └── monitor/
│   │
│   └── widgets/
│       ├── common/
│       ├── charts/
│       └── video/
│
├── l10n/
│   ├── app_en.arb               # Ingles
│   ├── app_es.arb               # Espanol
│   └── l10n.yaml
│
└── assets/
    ├── images/
    ├── icons/
    ├── fonts/
    └── video/
```

---

## Configuracion e Instalacion

### Requisitos Previos

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Proyecto Firebase configurado

### Instalacion

1. **Clonar el repositorio**
```bash
git clone <repository-url>
cd blincar_app
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Generar codigo (Freezed, JSON Serialization)**
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. **Generar localizaciones**
```bash
flutter gen-l10n
```

5. **Ejecutar la aplicacion**
```bash
# Para pasajeros
flutter run -t lib/main.dart

# Para conductores
flutter run -t lib/main_driver.dart

# Para monitores
flutter run -t lib/main_monitor.dart
```

---

## Modelos de Datos

### User (Usuario/Pasajero)
```dart
User {
  id: String,
  email: String,
  phoneNumber: String,
  fullName: String,
  photoURL: String?,
  phoneVerified: bool,
  emailVerified: bool,
  emergencyContactName: String?,
  emergencyContactPhone: String?,
  createdAt: DateTime
}
```

### TripEntity (Viaje)
```dart
TripEntity {
  id: String,
  userId: String,
  userName: String,
  userPhone: String,
  route: RouteEntity,
  serviceType: String,
  totalPrice: double,
  status: TripStatus,

  // Conductor asignado
  driverId: String?,
  driverName: String?,
  driverPhone: String?,
  vehicleId: String?,
  vehiclePlate: String?,

  // Timestamps
  requestedAt: DateTime,
  assignedAt: DateTime?,
  startedAt: DateTime?,
  completedAt: DateTime?,
  videoSessionId: String?
}
```

### Driver (Conductor)
```dart
Driver {
  id: String,
  firebaseUid: String,
  email: String,
  phoneNumber: String,
  fullName: String,
  licenseNumber: String?,
  isAvailable: bool,
  isActive: bool,
  currentTripId: String?,
  currentLocation: Coordinates?,
  rating: double?,
  totalTrips: int
}
```

### Vehicle (Vehiculo)
```dart
Vehicle {
  id: String,
  brand: String,
  model: String,
  year: int,
  type: VehicleType,
  licensePlate: String,
  capacity: int,
  isArmored: bool,
  armorLevel: String?,
  color: String,
  isAvailable: bool
}
```

### Estados de Viaje

| Estado | Descripcion |
|--------|-------------|
| `pending` | Esperando asignacion de conductor |
| `assigned` | Conductor asignado |
| `inProgress` | Viaje en curso |
| `completed` | Viaje completado |
| `cancelled` | Viaje cancelado |

### Tipos de Vehiculos

| Tipo | Descripcion |
|------|-------------|
| `suv` | SUV estandar |
| `suburbanBlindado` | Suburban blindado |
| `escalade` | Cadillac Escalade |
| `landRover` | Land Rover |
| `explorer` | Ford Explorer |
| `bmwF800` | BMW F800 (Motocicleta) |

---

## Servicios y Repositorios

### AuthRepository
```dart
// Metodos principales
login(email, password) -> Either<Failure, User>
register(email, password, fullName, ...) -> Either<Failure, User>
logout() -> Either<Failure, void>
getCurrentUser() -> Either<Failure, User>
authStateChanges -> Stream<User?>
```

### TripRepository
```dart
// Metodos principales
createTripRequest({userId, userName, userPhone, routeId, serviceType, totalPrice})
getTripById(tripId)
getUserTrips(userId)
getUserActiveTrip(userId)
watchTrip(tripId) -> Stream
assignDriver({tripId, driverId, driverName, ...})
startTrip({tripId, videoSessionId})
completeTrip({tripId})
cancelTrip({tripId, reason})
getPendingRequests() / watchPendingRequests() -> Stream
getActiveTrips() / watchActiveTrips() -> Stream
```

### StorageService
```dart
saveAuthData(token, userId, userRole)
getToken() / getUserId() / getUserRole()
clearAuthData()
isLoggedIn()
saveLocale(locale) / getLocale()
saveActiveTripId(tripId) / getActiveTripId()
```

### LocationService
```dart
getCurrentLocation() -> Position
getAddressFromCoordinates(lat, lng) -> String
getLocationStream() -> Stream<Position>
calculateDistance(startLat, startLng, endLat, endLng) -> double
```

---

## Pantallas Principales

### Flujo del Pasajero

```
SplashPage -> LoginPage/RegisterPage -> HomePage
                                           |
                    +----------------------+----------------------+
                    |                      |                      |
              TripRequestPage       ActivityPage          ProfilePage
                    |
            WaitingAssignmentPage
                    |
            TripTrackingScreen --- PanicPage
                    |
              (Completado)
```

### Flujo del Conductor

```
DriverLoginPage -> DriverHomePage
                        |
                   Viajes disponibles
                        |
                   Aceptar viaje
                        |
                   Transmitir video
                        |
                Iniciar/Completar viaje
```

### Flujo del Monitor

```
MonitorLoginPage -> MonitorDashboardPage
                           |
          +----------------+----------------+
          |                |                |
      Pendientes       Activos        Completados
          |
    AssignTripDialog
```

---

## Firebase Integration

### Proyecto Firebase
- **Project ID**: `blin-car1`
- **Database URL**: `https://blin-car1-default-rtdb.firebaseio.com`
- **Storage Bucket**: `blin-car1.firebasestorage.app`

### Estructura Realtime Database
```
/blincar
  /trips
    /{tripId}
      - id, userId, status, route, price, etc.
  /tripRequests
    /pending/{tripId}: true
    /active/{tripId}: true
  /userTrips
    /{userId}/{tripId}: true
  /drivers
    /{driverId}
      - id, name, location, available, etc.
  /vehicles
    /{vehicleId}
      - id, brand, model, type, licensePlate, etc.
```

### Servicios Firebase Utilizados

| Servicio | Uso |
|----------|-----|
| **Firebase Auth** | Autenticacion email/password |
| **Realtime Database** | Viajes, conductores, ubicaciones en tiempo real |
| **Cloud Storage** | Almacenamiento de videos |
| **Cloud Messaging** | Push notifications |

---

## Tema y Diseno

### Paleta de Colores

| Color | Hex | Uso |
|-------|-----|-----|
| Primary | `#1B2B5E` | Color principal (azul oscuro) |
| Primary Light | `#010130` | Azul mas claro |
| Primary Dark | `#0A1538` | Azul muy oscuro |
| Secondary | `#00BCD4` | Cian/Turquesa |
| Accent | `#4FC3F7` | Cian claro |
| Background | `#010130` | Fondo principal |
| Surface | `#253A7D` | Superficie de cards |
| Success | `#4CAF50` | Verde exito |
| Warning | `#FF9800` | Naranja advertencia |
| Error | `#F44336` | Rojo error |

### Tipografia

- **Poppins**: Fuente principal del UI
- **Montserrat**: Fuentes adicionales (Bold, Medium, Black)

### Tema

- Dark theme Material Design 3
- Diseno oscuro para seguridad/privacidad visual

---

## Internacionalizacion

### Idiomas Soportados

| Idioma | Archivo |
|--------|---------|
| Espanol | `lib/l10n/app_es.arb` |
| Ingles | `lib/l10n/app_en.arb` |

### Uso
```dart
// En widgets
Text(AppLocalizations.of(context)!.login)
```

---

## Dependencias

### Framework y UI
| Dependencia | Version | Uso |
|-------------|---------|-----|
| flutter_bloc | 8.1.6 | Gestion de estado |
| equatable | 2.0.5 | Comparacion de objetos |
| freezed_annotation | 2.4.1 | Modelos inmutables |
| json_annotation | 4.9.0 | JSON serialization |

### Firebase
| Dependencia | Version | Uso |
|-------------|---------|-----|
| firebase_core | 3.6.0 | Core |
| firebase_auth | 5.3.1 | Autenticacion |
| firebase_database | 11.1.4 | Realtime Database |
| firebase_storage | 12.3.2 | Storage |
| firebase_messaging | 15.1.3 | Push notifications |

### Mapas y Localizacion
| Dependencia | Version | Uso |
|-------------|---------|-----|
| google_maps_flutter | 2.6.1 | Mapas |
| geolocator | 10.1.0 | GPS |
| permission_handler | 11.3.1 | Permisos |
| geocoding | 3.0.0 | Reverse geocoding |

### Multimedia
| Dependencia | Version | Uso |
|-------------|---------|-----|
| flutter_vlc_player | 7.4.0 | Reproductor RTSP |
| camera | 0.10.5+9 | Camara del dispositivo |
| video_player | 2.9.1 | Reproductor de video |

### Utilidades
| Dependencia | Version | Uso |
|-------------|---------|-----|
| get_it | 7.6.9 | Service Locator |
| dartz | 0.10.1 | Functional programming |
| shared_preferences | 2.2.2 | Almacenamiento local |
| dio | 5.4.3 | Cliente HTTP |

---

## Manejo de Errores

### Tipos de Failure

| Failure | Descripcion |
|---------|-------------|
| `ServerFailure` | Errores HTTP/API |
| `CacheFailure` | Errores de almacenamiento local |
| `NetworkFailure` | Sin conexion |
| `ValidationFailure` | Datos invalidos |
| `AuthenticationFailure` | Login/registro fallido |
| `LocationFailure` | Problemas con GPS |
| `PermissionFailure` | Permisos denegados |
| `FirebaseFailure` | Errores de Firebase |
| `TripFailure` | Errores en viajes |

---

## Comandos Utiles

```bash
# Instalar dependencias
flutter pub get

# Generar codigo (Freezed, JSON)
dart run build_runner build --delete-conflicting-outputs

# Generar localizaciones
flutter gen-l10n

# Ejecutar tests
flutter test

# Analizar codigo
flutter analyze

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release
```

---

## Licencia

Este proyecto es propietario de Blincar.

---

## Contacto

Para mas informacion sobre el proyecto, contactar al equipo de desarrollo.
