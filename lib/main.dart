// lib/main.dart

import 'package:blincar_app/firebase_options.dart';
import 'package:blincar_app/presentation/pages/splash/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'core/core.dart';
import 'core/config/env_config.dart';
import 'core/services/stripe_service.dart';
import 'presentation/presentation.dart';

/// Punto de entrada de la aplicacion Blincar
///
/// Responsabilidades:
/// 1. Cargar variables de entorno (.env)
/// 2. Inicializar Firebase
/// 3. Inicializar Stripe
/// 4. Configurar el Service Locator (Dependency Injection)
/// 5. Configurar el tema, localizacion y rutas
void main() async {
  // Asegurar que Flutter este inicializado antes de usar plugins
  WidgetsFlutterBinding.ensureInitialized();

  // 🔐 CARGAR VARIABLES DE ENTORNO
  try {
    await EnvConfig.initialize();
    _log('Variables de entorno cargadas');
  } catch (e) {
    _log('Error cargando .env: $e');
  }

  // 🔥 INICIALIZAR FIREBASE
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _log('Firebase inicializado correctamente');
  } catch (e) {
    _log('Error al inicializar Firebase: $e');
  }

  // 💳 INICIALIZAR STRIPE
  try {
    await StripeService.initialize();
    _log('Stripe inicializado correctamente');
  } catch (e) {
    _log('Error al inicializar Stripe: $e');
  }

  // Configurar dependencias (Repositories, Use Cases, BLoCs)
  await setupServiceLocator();

  runApp(const BlincarApp());
}

/// Log condicional - solo muestra en debug, nunca en release
void _log(String message) {
  if (kDebugMode) {
    debugPrint('[Blincar] $message');
  }
}

class BlincarApp extends StatelessWidget {
  const BlincarApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el idioma del sistema para inicialización
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;

    return MultiBlocProvider(
      providers: [
        // BLoC de idioma/localización
        BlocProvider<LocaleBloc>(
          create: (context) => getIt<LocaleBloc>()
            ..add(LocaleEvent.initialize(systemLocale: systemLocale)),
        ),

        // BLoC de autenticación (usa FirebaseAuthRepository)
        BlocProvider<AuthBloc>(
          create: (context) => getIt<AuthBloc>(),
        ),

        // TODO: Agregar más BLoCs según sea necesario:
        // BlocProvider<TripRequestBloc>(...),
        // BlocProvider<TrackingBloc>(...),
      ],
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, localeState) {
          return MaterialApp(
            title: 'Blincar',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkTheme,

            // Configuración de localización
            locale: localeState.locale,
            supportedLocales: LocaleBloc.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            // Resolver el locale cuando no hay coincidencia exacta
            localeResolutionCallback: (locale, supportedLocales) {
              // Si el locale del dispositivo está soportado, usarlo
              for (final supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode) {
                  return supportedLocale;
                }
              }
              // Fallback a español
              return const Locale('es', 'MX');
            },

            home: const SplashPage(),

            // TODO: Configurar navegación con rutas nombradas
            // routes: AppRoutes.routes,
            // onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
