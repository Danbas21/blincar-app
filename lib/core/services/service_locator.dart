// lib/core/services/service_locator.dart

import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../constants/api_constants.dart';
import '../security/ssl_pinning_service.dart';
import '../security/secure_storage_service.dart';
import '../../data/repositories/firebase_auth_repository.dart';
import '../../data/repositories/firebase_trip_repository.dart';
import '../../data/repositories/stripe_payment_repository.dart';
import '../../data/repositories/fcm_repository_impl.dart';
import '../../data/datasources/remote/fcm_remote_data_source.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/trip_repository.dart';
import '../../domain/repositories/payment_repository.dart';
import '../../domain/repositories/fcm_repository.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/register_usecase.dart';
import '../../domain/usecases/auth/update_profile_usecase.dart';
import '../../domain/usecases/auth/update_email_usecase.dart';
import '../../domain/usecases/auth/update_password_usecase.dart';
import '../../domain/usecases/auth/upload_profile_photo_usecase.dart';
import '../../domain/usecases/trip/create_trip_request_usecase.dart';
import '../../domain/usecases/trip/get_trip_by_id_usecase.dart';
import '../../domain/usecases/trip/get_user_active_trip_usecase.dart';
import '../../domain/usecases/trip/get_user_trips_usecase.dart';
import '../../domain/usecases/trip/watch_trip_usecase.dart';
import '../../domain/usecases/payment/add_payment_card_usecase.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import '../../presentation/bloc/locale/locale_bloc.dart';
import '../../presentation/bloc/trip/trip_request_bloc.dart';
import '../../presentation/bloc/payment/payment_bloc.dart';
import 'api_service.dart';
import 'storage_service.dart';
import 'location_tracking_service.dart';
import 'stripe_service.dart';
import 'stripe_backend_service.dart';
import 'google_directions_service.dart';
import 'fcm_manager.dart';
import 'auth_fcm_listener.dart';

final GetIt getIt = GetIt.instance;

/// Configura todas las dependencias de la aplicacion
///
/// Orden de registro (siguiendo principio de Dependency Inversion):
/// 1. External dependencies (SharedPreferences, Dio, Firebase)
/// 2. Core services (ApiService, StorageService)
/// 3. Data sources (si los hay)
/// 4. Repositories
/// 5. Use cases
/// 6. BLoCs
///
/// IMPORTANTE: Respetar el orden de dependencias.
/// Un servicio solo puede depender de servicios registrados antes que el.
Future<void> setupServiceLocator() async {
  // ========================================
  // 1. EXTERNAL DEPENDENCIES
  // ========================================

  // SharedPreferences (async initialization)
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Dio HTTP Client con SSL Pinning
  final dio = Dio();
  dio.options.baseUrl = ApiConstants.baseUrl;
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);

  // 🔒 Configurar SSL Pinning para proteger contra ataques MITM
  SslPinningService.configureDio(dio);

  getIt.registerLazySingleton<Dio>(() => dio);

  // Firebase Auth
  getIt.registerLazySingleton<firebase_auth.FirebaseAuth>(
    () => firebase_auth.FirebaseAuth.instance,
  );

  // Firebase Realtime Database
  getIt.registerLazySingleton<FirebaseDatabase>(
    () => FirebaseDatabase.instance,
  );

  // Firebase Storage
  getIt.registerLazySingleton<FirebaseStorage>(
    () => FirebaseStorage.instance,
  );

  // ========================================
  // 2. CORE SERVICES
  // ========================================

  getIt.registerLazySingleton<ApiService>(
    () => ApiService(getIt<Dio>()),
  );

  // 🔒 Secure Storage Service (para datos sensibles)
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );

  // Storage Service (combina SharedPreferences + SecureStorage)
  final storageService = StorageService(
    getIt<SharedPreferences>(),
    getIt<SecureStorageService>(),
  );
  // Migrar datos legacy a almacenamiento seguro
  await storageService.initialize();
  getIt.registerLazySingleton<StorageService>(() => storageService);

  getIt.registerLazySingleton<LocationTrackingService>(
    () => LocationTrackingService(database: getIt<FirebaseDatabase>()),
  );

  getIt.registerLazySingleton<StripeService>(
    () => StripeService(),
  );

  getIt.registerLazySingleton<StripeBackendService>(
    () => StripeBackendService(),
  );

  getIt.registerLazySingleton<GoogleDirectionsService>(
    () => GoogleDirectionsService(),
  );

  // Auth FCM Listener (registra tokens cuando el usuario se autentica)
  getIt.registerLazySingleton<AuthFcmListener>(
    () => AuthFcmListener(
      firebaseAuth: getIt<firebase_auth.FirebaseAuth>(),
      fcmManager: getIt<FcmManager>(),
    ),
  );

  // ========================================
  // 3. DATA SOURCES
  // ========================================

  // FCM Remote Data Source (requiere Dio con auth interceptor)
  getIt.registerLazySingleton<FcmRemoteDataSource>(
    () => FcmRemoteDataSourceImpl(dio: getIt<Dio>()),
  );

  // ========================================
  // 4. REPOSITORIES
  // ========================================

  // Auth Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => FirebaseAuthRepository(
      firebaseAuth: getIt<firebase_auth.FirebaseAuth>(),
      firebaseStorage: getIt<FirebaseStorage>(),
      firebaseDatabase: getIt<FirebaseDatabase>(),
    ),
  );

  // Trip Repository
  getIt.registerLazySingleton<TripRepository>(
    () => FirebaseTripRepository(
      database: getIt<FirebaseDatabase>(),
    ),
  );

  // Payment Repository
  getIt.registerLazySingleton<PaymentRepository>(
    () => StripePaymentRepository(
      database: getIt<FirebaseDatabase>(),
      stripeService: getIt<StripeService>(),
    ),
  );

  // FCM Repository (Push Notifications)
  getIt.registerLazySingleton<FcmRepository>(
    () => FcmRepositoryImpl(
      remoteDataSource: getIt<FcmRemoteDataSource>(),
    ),
  );

  // FCM Manager (maneja registro automático de tokens)
  getIt.registerLazySingleton<FcmManager>(
    () => FcmManager(
      fcmRepository: getIt<FcmRepository>(),
    ),
  );

  // ========================================
  // 5. USE CASES
  // ========================================

  // Auth Use Cases - Autenticación
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );

  // Auth Use Cases - Edición de Perfil
  getIt.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<UpdateEmailUseCase>(
    () => UpdateEmailUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<UpdatePasswordUseCase>(
    () => UpdatePasswordUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<UploadProfilePhotoUseCase>(
    () => UploadProfilePhotoUseCase(getIt<AuthRepository>()),
  );

  // Trip Use Cases
  getIt.registerLazySingleton<CreateTripRequestUseCase>(
    () => CreateTripRequestUseCase(getIt<TripRepository>()),
  );

  getIt.registerLazySingleton<GetTripByIdUseCase>(
    () => GetTripByIdUseCase(getIt<TripRepository>()),
  );

  getIt.registerLazySingleton<GetUserActiveTripUseCase>(
    () => GetUserActiveTripUseCase(getIt<TripRepository>()),
  );

  getIt.registerLazySingleton<GetUserTripsUseCase>(
    () => GetUserTripsUseCase(getIt<TripRepository>()),
  );

  getIt.registerLazySingleton<WatchTripUseCase>(
    () => WatchTripUseCase(getIt<TripRepository>()),
  );

  // Payment Use Cases
  getIt.registerLazySingleton<AddPaymentCardUseCase>(
    () => AddPaymentCardUseCase(getIt<PaymentRepository>()),
  );

  // ========================================
  // 6. BLOCS (Factory - nueva instancia cada vez)
  // ========================================

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: getIt<LoginUseCase>(),
      registerUseCase: getIt<RegisterUseCase>(),
      authRepository: getIt<AuthRepository>(),
      updateProfileUseCase: getIt<UpdateProfileUseCase>(),
      updateEmailUseCase: getIt<UpdateEmailUseCase>(),
      updatePasswordUseCase: getIt<UpdatePasswordUseCase>(),
      uploadProfilePhotoUseCase: getIt<UploadProfilePhotoUseCase>(),
    ),
  );

  getIt.registerFactory<LocaleBloc>(
    () => LocaleBloc(getIt<StorageService>()),
  );

  getIt.registerFactory<TripRequestBloc>(
    () => TripRequestBloc(
      createTripRequestUseCase: getIt<CreateTripRequestUseCase>(),
      getUserActiveTripUseCase: getIt<GetUserActiveTripUseCase>(),
      getUserTripsUseCase: getIt<GetUserTripsUseCase>(),
      watchTripUseCase: getIt<WatchTripUseCase>(),
    ),
  );

  getIt.registerFactory<PaymentBloc>(
    () => PaymentBloc(
      paymentRepository: getIt<PaymentRepository>(),
    ),
  );

}

/// Resetea todas las dependencias registradas
///
/// Util para testing o cuando se necesita reiniciar el estado
Future<void> resetServiceLocator() async {
  await getIt.reset();
}
