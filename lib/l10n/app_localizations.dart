import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appName.
  ///
  /// In es, this message translates to:
  /// **'Blincar'**
  String get appName;

  /// No description provided for @welcome.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido a Blincar'**
  String get welcome;

  /// No description provided for @login.
  ///
  /// In es, this message translates to:
  /// **'Iniciar Sesión'**
  String get login;

  /// No description provided for @register.
  ///
  /// In es, this message translates to:
  /// **'Registrarse'**
  String get register;

  /// No description provided for @email.
  ///
  /// In es, this message translates to:
  /// **'Correo Electrónico'**
  String get email;

  /// No description provided for @password.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get password;

  /// No description provided for @firstName.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In es, this message translates to:
  /// **'Apellidos'**
  String get lastName;

  /// No description provided for @phone.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get phone;

  /// No description provided for @emergencyContact.
  ///
  /// In es, this message translates to:
  /// **'Contacto de Emergencia'**
  String get emergencyContact;

  /// No description provided for @emergencyContactPhone.
  ///
  /// In es, this message translates to:
  /// **'Teléfono de Emergencia'**
  String get emergencyContactPhone;

  /// No description provided for @requestTrip.
  ///
  /// In es, this message translates to:
  /// **'Solicitar Viaje'**
  String get requestTrip;

  /// No description provided for @tripNow.
  ///
  /// In es, this message translates to:
  /// **'Viaje Ahora'**
  String get tripNow;

  /// No description provided for @tripByHour.
  ///
  /// In es, this message translates to:
  /// **'Viaje por Hora'**
  String get tripByHour;

  /// No description provided for @tripByDay.
  ///
  /// In es, this message translates to:
  /// **'Viaje por Días'**
  String get tripByDay;

  /// No description provided for @carWithDriver.
  ///
  /// In es, this message translates to:
  /// **'Auto con Chofer'**
  String get carWithDriver;

  /// No description provided for @armoredCar.
  ///
  /// In es, this message translates to:
  /// **'Auto Blindado'**
  String get armoredCar;

  /// No description provided for @armedEscort.
  ///
  /// In es, this message translates to:
  /// **'Auto con Escolta Armado'**
  String get armedEscort;

  /// No description provided for @unarmedEscort.
  ///
  /// In es, this message translates to:
  /// **'Auto con Escolta Desarmado'**
  String get unarmedEscort;

  /// No description provided for @panicButton.
  ///
  /// In es, this message translates to:
  /// **'Botón de Pánico'**
  String get panicButton;

  /// No description provided for @myAccount.
  ///
  /// In es, this message translates to:
  /// **'Mi Cuenta'**
  String get myAccount;

  /// No description provided for @activity.
  ///
  /// In es, this message translates to:
  /// **'Actividad'**
  String get activity;

  /// No description provided for @wallet.
  ///
  /// In es, this message translates to:
  /// **'Billetera'**
  String get wallet;

  /// No description provided for @notifications.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get notifications;

  /// No description provided for @settings.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get settings;

  /// No description provided for @profile.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get profile;

  /// No description provided for @paymentMethods.
  ///
  /// In es, this message translates to:
  /// **'Métodos de Pago'**
  String get paymentMethods;

  /// No description provided for @tripHistory.
  ///
  /// In es, this message translates to:
  /// **'Historial de Viajes'**
  String get tripHistory;

  /// No description provided for @earnings.
  ///
  /// In es, this message translates to:
  /// **'Ganancias'**
  String get earnings;

  /// No description provided for @documentation.
  ///
  /// In es, this message translates to:
  /// **'Documentación'**
  String get documentation;

  /// No description provided for @verification.
  ///
  /// In es, this message translates to:
  /// **'Verificación'**
  String get verification;

  /// No description provided for @uploadDocument.
  ///
  /// In es, this message translates to:
  /// **'Subir Documento'**
  String get uploadDocument;

  /// No description provided for @takePhoto.
  ///
  /// In es, this message translates to:
  /// **'Tomar Foto'**
  String get takePhoto;

  /// No description provided for @pickFromGallery.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar de Galería'**
  String get pickFromGallery;

  /// No description provided for @driverLicense.
  ///
  /// In es, this message translates to:
  /// **'Licencia de Conducir'**
  String get driverLicense;

  /// No description provided for @vehicleRegistration.
  ///
  /// In es, this message translates to:
  /// **'Registro del Vehículo'**
  String get vehicleRegistration;

  /// No description provided for @insurance.
  ///
  /// In es, this message translates to:
  /// **'Seguro'**
  String get insurance;

  /// No description provided for @backgroundCheck.
  ///
  /// In es, this message translates to:
  /// **'Verificación de Antecedentes'**
  String get backgroundCheck;

  /// No description provided for @startTrip.
  ///
  /// In es, this message translates to:
  /// **'Iniciar Viaje'**
  String get startTrip;

  /// No description provided for @endTrip.
  ///
  /// In es, this message translates to:
  /// **'Finalizar Viaje'**
  String get endTrip;

  /// No description provided for @cancelTrip.
  ///
  /// In es, this message translates to:
  /// **'Cancelar Viaje'**
  String get cancelTrip;

  /// No description provided for @rateTrip.
  ///
  /// In es, this message translates to:
  /// **'Calificar Viaje'**
  String get rateTrip;

  /// No description provided for @paymentSuccessful.
  ///
  /// In es, this message translates to:
  /// **'Pago Exitoso'**
  String get paymentSuccessful;

  /// No description provided for @paymentFailed.
  ///
  /// In es, this message translates to:
  /// **'Pago No Realizado'**
  String get paymentFailed;

  /// No description provided for @cashPayment.
  ///
  /// In es, this message translates to:
  /// **'Pago en Efectivo'**
  String get cashPayment;

  /// No description provided for @cardPayment.
  ///
  /// In es, this message translates to:
  /// **'Pago con Tarjeta'**
  String get cardPayment;

  /// No description provided for @routeChangeRequest.
  ///
  /// In es, this message translates to:
  /// **'Solicitud de Cambio de Ruta'**
  String get routeChangeRequest;

  /// No description provided for @approveRouteChange.
  ///
  /// In es, this message translates to:
  /// **'Aprobar Cambio'**
  String get approveRouteChange;

  /// No description provided for @rejectRouteChange.
  ///
  /// In es, this message translates to:
  /// **'Rechazar Cambio'**
  String get rejectRouteChange;

  /// No description provided for @emergencyContactMessage.
  ///
  /// In es, this message translates to:
  /// **'{name} requiere de tu apoyo y seguimiento'**
  String emergencyContactMessage(String name);

  /// No description provided for @monthlyEarnings.
  ///
  /// In es, this message translates to:
  /// **'Ganancias Mensuales'**
  String get monthlyEarnings;

  /// No description provided for @totalTrips.
  ///
  /// In es, this message translates to:
  /// **'Viajes Totales'**
  String get totalTrips;

  /// No description provided for @rating.
  ///
  /// In es, this message translates to:
  /// **'Calificación'**
  String get rating;

  /// No description provided for @available.
  ///
  /// In es, this message translates to:
  /// **'Disponible'**
  String get available;

  /// No description provided for @busy.
  ///
  /// In es, this message translates to:
  /// **'Ocupado'**
  String get busy;

  /// No description provided for @offline.
  ///
  /// In es, this message translates to:
  /// **'Desconectado'**
  String get offline;

  /// No description provided for @privacyPolicy.
  ///
  /// In es, this message translates to:
  /// **'Política de Privacidad'**
  String get privacyPolicy;

  /// No description provided for @termsAndConditions.
  ///
  /// In es, this message translates to:
  /// **'Términos y Condiciones'**
  String get termsAndConditions;

  /// No description provided for @legalNotices.
  ///
  /// In es, this message translates to:
  /// **'Avisos Legales'**
  String get legalNotices;

  /// No description provided for @acceptTerms.
  ///
  /// In es, this message translates to:
  /// **'Acepto los términos y condiciones'**
  String get acceptTerms;

  /// No description provided for @acceptPrivacyPolicy.
  ///
  /// In es, this message translates to:
  /// **'Acepto la política de privacidad'**
  String get acceptPrivacyPolicy;

  /// No description provided for @currency.
  ///
  /// In es, this message translates to:
  /// **'MXN'**
  String get currency;

  /// No description provided for @region.
  ///
  /// In es, this message translates to:
  /// **'México'**
  String get region;

  /// No description provided for @language.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get language;

  /// No description provided for @languageSettings.
  ///
  /// In es, this message translates to:
  /// **'Configuración de Idioma'**
  String get languageSettings;

  /// No description provided for @selectLanguage.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar Idioma'**
  String get selectLanguage;

  /// No description provided for @spanish.
  ///
  /// In es, this message translates to:
  /// **'Español'**
  String get spanish;

  /// No description provided for @english.
  ///
  /// In es, this message translates to:
  /// **'Inglés'**
  String get english;

  /// No description provided for @languageChanged.
  ///
  /// In es, this message translates to:
  /// **'Idioma cambiado correctamente'**
  String get languageChanged;

  /// No description provided for @systemLanguage.
  ///
  /// In es, this message translates to:
  /// **'Idioma del sistema'**
  String get systemLanguage;

  /// No description provided for @useSystemLanguage.
  ///
  /// In es, this message translates to:
  /// **'Usar idioma del dispositivo'**
  String get useSystemLanguage;

  /// No description provided for @currentLanguage.
  ///
  /// In es, this message translates to:
  /// **'Idioma actual'**
  String get currentLanguage;

  /// No description provided for @changeLanguage.
  ///
  /// In es, this message translates to:
  /// **'Cambiar idioma'**
  String get changeLanguage;

  /// No description provided for @languageDescription.
  ///
  /// In es, this message translates to:
  /// **'Selecciona el idioma de la aplicación'**
  String get languageDescription;

  /// No description provided for @editProfile.
  ///
  /// In es, this message translates to:
  /// **'Editar Perfil'**
  String get editProfile;

  /// No description provided for @fullName.
  ///
  /// In es, this message translates to:
  /// **'Nombre Completo'**
  String get fullName;

  /// No description provided for @saveChanges.
  ///
  /// In es, this message translates to:
  /// **'Guardar Cambios'**
  String get saveChanges;

  /// No description provided for @updateEmail.
  ///
  /// In es, this message translates to:
  /// **'Actualizar Correo'**
  String get updateEmail;

  /// No description provided for @updatePassword.
  ///
  /// In es, this message translates to:
  /// **'Actualizar Contraseña'**
  String get updatePassword;

  /// No description provided for @currentPassword.
  ///
  /// In es, this message translates to:
  /// **'Contraseña Actual'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In es, this message translates to:
  /// **'Nueva Contraseña'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In es, this message translates to:
  /// **'Confirmar Contraseña'**
  String get confirmPassword;

  /// No description provided for @profileUpdated.
  ///
  /// In es, this message translates to:
  /// **'Perfil actualizado correctamente'**
  String get profileUpdated;

  /// No description provided for @passwordUpdated.
  ///
  /// In es, this message translates to:
  /// **'Contraseña actualizada correctamente'**
  String get passwordUpdated;

  /// No description provided for @changePhoto.
  ///
  /// In es, this message translates to:
  /// **'Cambiar Foto'**
  String get changePhoto;

  /// No description provided for @camera.
  ///
  /// In es, this message translates to:
  /// **'Cámara'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In es, this message translates to:
  /// **'Galería'**
  String get gallery;

  /// No description provided for @logout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar Sesión'**
  String get logout;

  /// No description provided for @logoutConfirmation.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que deseas cerrar sesión?'**
  String get logoutConfirmation;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In es, this message translates to:
  /// **'Confirmar'**
  String get confirm;

  /// No description provided for @yes.
  ///
  /// In es, this message translates to:
  /// **'Sí'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @error.
  ///
  /// In es, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In es, this message translates to:
  /// **'Éxito'**
  String get success;

  /// No description provided for @loading.
  ///
  /// In es, this message translates to:
  /// **'Cargando...'**
  String get loading;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @noData.
  ///
  /// In es, this message translates to:
  /// **'Sin datos'**
  String get noData;

  /// No description provided for @home.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get home;

  /// No description provided for @routes.
  ///
  /// In es, this message translates to:
  /// **'Rutas'**
  String get routes;

  /// No description provided for @emergencyContactName.
  ///
  /// In es, this message translates to:
  /// **'Nombre del Contacto'**
  String get emergencyContactName;

  /// No description provided for @emergencyContactNameHint.
  ///
  /// In es, this message translates to:
  /// **'Ej: María García'**
  String get emergencyContactNameHint;

  /// No description provided for @emergencyContactDescription.
  ///
  /// In es, this message translates to:
  /// **'Este contacto será llamado automáticamente cuando actives el botón de pánico'**
  String get emergencyContactDescription;

  /// No description provided for @emergencyContactRequired.
  ///
  /// In es, this message translates to:
  /// **'Debes configurar un contacto de emergencia'**
  String get emergencyContactRequired;

  /// No description provided for @nameRequired.
  ///
  /// In es, this message translates to:
  /// **'El nombre es requerido'**
  String get nameRequired;

  /// No description provided for @nameTooShort.
  ///
  /// In es, this message translates to:
  /// **'El nombre debe tener al menos 2 caracteres'**
  String get nameTooShort;

  /// No description provided for @phoneRequired.
  ///
  /// In es, this message translates to:
  /// **'El teléfono es requerido'**
  String get phoneRequired;

  /// No description provided for @phoneInvalid.
  ///
  /// In es, this message translates to:
  /// **'Ingresa un número de teléfono válido'**
  String get phoneInvalid;

  /// No description provided for @whenContacted.
  ///
  /// In es, this message translates to:
  /// **'¿Cuándo se contactará?'**
  String get whenContacted;

  /// No description provided for @contactInfoPanic.
  ///
  /// In es, this message translates to:
  /// **'Cuando actives el botón de pánico'**
  String get contactInfoPanic;

  /// No description provided for @contactInfoCall.
  ///
  /// In es, this message translates to:
  /// **'Recibirá una llamada automática'**
  String get contactInfoCall;

  /// No description provided for @contactInfoLocation.
  ///
  /// In es, this message translates to:
  /// **'Se compartirá tu ubicación en tiempo real'**
  String get contactInfoLocation;

  /// No description provided for @contactInfoSms.
  ///
  /// In es, this message translates to:
  /// **'Recibirá un SMS con información del viaje'**
  String get contactInfoSms;

  /// No description provided for @configureEmergencyContact.
  ///
  /// In es, this message translates to:
  /// **'Configurar contacto de emergencia'**
  String get configureEmergencyContact;

  /// No description provided for @notConfigured.
  ///
  /// In es, this message translates to:
  /// **'No configurado'**
  String get notConfigured;

  /// No description provided for @panicTitle.
  ///
  /// In es, this message translates to:
  /// **'Botón de Pánico'**
  String get panicTitle;

  /// No description provided for @panicAlertActive.
  ///
  /// In es, this message translates to:
  /// **'ALERTA ACTIVA'**
  String get panicAlertActive;

  /// No description provided for @emergencySystem.
  ///
  /// In es, this message translates to:
  /// **'Sistema de Emergencia'**
  String get emergencySystem;

  /// No description provided for @panicActivateInfo.
  ///
  /// In es, this message translates to:
  /// **'Al activar el botón de pánico:'**
  String get panicActivateInfo;

  /// No description provided for @panicFeature1.
  ///
  /// In es, this message translates to:
  /// **'Se notifica a autoridades locales'**
  String get panicFeature1;

  /// No description provided for @panicFeature2.
  ///
  /// In es, this message translates to:
  /// **'Se contacta a tu contacto de emergencia'**
  String get panicFeature2;

  /// No description provided for @panicFeature3.
  ///
  /// In es, this message translates to:
  /// **'Se graba audio y video automáticamente'**
  String get panicFeature3;

  /// No description provided for @panicFeature4.
  ///
  /// In es, this message translates to:
  /// **'Se comparte tu ubicación en tiempo real'**
  String get panicFeature4;

  /// No description provided for @panicFeature5.
  ///
  /// In es, this message translates to:
  /// **'Se envía alerta a otros conductores cercanos'**
  String get panicFeature5;

  /// No description provided for @activatingAlertIn.
  ///
  /// In es, this message translates to:
  /// **'ACTIVANDO ALERTA EN:'**
  String get activatingAlertIn;

  /// No description provided for @alertSent.
  ///
  /// In es, this message translates to:
  /// **'ALERTA ENVIADA - Autoridades y contactos notificados'**
  String get alertSent;

  /// No description provided for @authoritiesNotified.
  ///
  /// In es, this message translates to:
  /// **'Las autoridades han sido notificadas y están en camino'**
  String get authoritiesNotified;

  /// No description provided for @authoritiesNotifiedStatus.
  ///
  /// In es, this message translates to:
  /// **'Autoridades notificadas'**
  String get authoritiesNotifiedStatus;

  /// No description provided for @emergencyContactCalled.
  ///
  /// In es, this message translates to:
  /// **'Contacto de emergencia llamado'**
  String get emergencyContactCalled;

  /// No description provided for @recordingStarted.
  ///
  /// In es, this message translates to:
  /// **'Grabación iniciada'**
  String get recordingStarted;

  /// No description provided for @locationShared.
  ///
  /// In es, this message translates to:
  /// **'Ubicación compartida'**
  String get locationShared;

  /// No description provided for @nearbyDriversAlerted.
  ///
  /// In es, this message translates to:
  /// **'Conductores cercanos alertados'**
  String get nearbyDriversAlerted;

  /// No description provided for @deactivateAlert.
  ///
  /// In es, this message translates to:
  /// **'DESACTIVAR ALERTA'**
  String get deactivateAlert;

  /// No description provided for @deactivateOnlySafe.
  ///
  /// In es, this message translates to:
  /// **'Solo desactiva si estás a salvo'**
  String get deactivateOnlySafe;

  /// No description provided for @emergencyContacts.
  ///
  /// In es, this message translates to:
  /// **'Contactos de Emergencia'**
  String get emergencyContacts;

  /// No description provided for @emergencies.
  ///
  /// In es, this message translates to:
  /// **'Emergencias'**
  String get emergencies;

  /// No description provided for @support247.
  ///
  /// In es, this message translates to:
  /// **'Soporte 24/7'**
  String get support247;

  /// No description provided for @callingContact.
  ///
  /// In es, this message translates to:
  /// **'Llamando a {name}...'**
  String callingContact(String name);

  /// No description provided for @callFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo realizar la llamada'**
  String get callFailed;

  /// No description provided for @noEmergencyContactConfigured.
  ///
  /// In es, this message translates to:
  /// **'No tienes un contacto de emergencia configurado'**
  String get noEmergencyContactConfigured;

  /// No description provided for @confirmDeactivation.
  ///
  /// In es, this message translates to:
  /// **'Confirmar desactivación'**
  String get confirmDeactivation;

  /// No description provided for @typeToConfirm.
  ///
  /// In es, this message translates to:
  /// **'Escribe: ESTOY SEGURO'**
  String get typeToConfirm;

  /// No description provided for @verifyPhone.
  ///
  /// In es, this message translates to:
  /// **'Verifica tu teléfono'**
  String get verifyPhone;

  /// No description provided for @enterPhoneToVerify.
  ///
  /// In es, this message translates to:
  /// **'Ingresa tu número de teléfono para recibir un código de verificación'**
  String get enterPhoneToVerify;

  /// No description provided for @sendCode.
  ///
  /// In es, this message translates to:
  /// **'Enviar código'**
  String get sendCode;

  /// No description provided for @enterVerificationCode.
  ///
  /// In es, this message translates to:
  /// **'Ingresa el código'**
  String get enterVerificationCode;

  /// No description provided for @codeSentTo.
  ///
  /// In es, this message translates to:
  /// **'Enviamos un código SMS a {phone}'**
  String codeSentTo(String phone);

  /// No description provided for @verify.
  ///
  /// In es, this message translates to:
  /// **'Verificar'**
  String get verify;

  /// No description provided for @resendCode.
  ///
  /// In es, this message translates to:
  /// **'Reenviar código'**
  String get resendCode;

  /// No description provided for @resendCodeIn.
  ///
  /// In es, this message translates to:
  /// **'Reenviar código en {seconds}s'**
  String resendCodeIn(int seconds);

  /// No description provided for @changePhoneNumber.
  ///
  /// In es, this message translates to:
  /// **'Cambiar número'**
  String get changePhoneNumber;

  /// No description provided for @phoneVerified.
  ///
  /// In es, this message translates to:
  /// **'Teléfono verificado correctamente'**
  String get phoneVerified;

  /// No description provided for @invalidCode.
  ///
  /// In es, this message translates to:
  /// **'Código incorrecto'**
  String get invalidCode;

  /// No description provided for @chatWithDriver.
  ///
  /// In es, this message translates to:
  /// **'Chat con conductor'**
  String get chatWithDriver;

  /// No description provided for @typeMessage.
  ///
  /// In es, this message translates to:
  /// **'Escribe un mensaje...'**
  String get typeMessage;

  /// No description provided for @send.
  ///
  /// In es, this message translates to:
  /// **'Enviar'**
  String get send;

  /// No description provided for @noMessages.
  ///
  /// In es, this message translates to:
  /// **'No hay mensajes aún'**
  String get noMessages;

  /// No description provided for @startConversation.
  ///
  /// In es, this message translates to:
  /// **'Inicia la conversación'**
  String get startConversation;

  /// No description provided for @rateYourTrip.
  ///
  /// In es, this message translates to:
  /// **'Califica tu viaje'**
  String get rateYourTrip;

  /// No description provided for @howWasYourTrip.
  ///
  /// In es, this message translates to:
  /// **'¿Cómo estuvo tu viaje?'**
  String get howWasYourTrip;

  /// No description provided for @leaveComment.
  ///
  /// In es, this message translates to:
  /// **'Deja un comentario (opcional)'**
  String get leaveComment;

  /// No description provided for @commentPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Cuéntanos sobre tu experiencia...'**
  String get commentPlaceholder;

  /// No description provided for @submitRating.
  ///
  /// In es, this message translates to:
  /// **'Enviar calificación'**
  String get submitRating;

  /// No description provided for @skipRating.
  ///
  /// In es, this message translates to:
  /// **'Omitir'**
  String get skipRating;

  /// No description provided for @thankYouForRating.
  ///
  /// In es, this message translates to:
  /// **'Gracias por tu calificación'**
  String get thankYouForRating;

  /// No description provided for @deleteAccount.
  ///
  /// In es, this message translates to:
  /// **'Eliminar cuenta'**
  String get deleteAccount;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In es, this message translates to:
  /// **'Esta acción es irreversible. Todos tus datos serán eliminados permanentemente.'**
  String get deleteAccountWarning;

  /// No description provided for @confirmDeleteAccount.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que quieres eliminar tu cuenta?'**
  String get confirmDeleteAccount;

  /// No description provided for @typeDeleteToConfirm.
  ///
  /// In es, this message translates to:
  /// **'Escribe ELIMINAR para confirmar'**
  String get typeDeleteToConfirm;

  /// No description provided for @accountDeleted.
  ///
  /// In es, this message translates to:
  /// **'Tu cuenta ha sido eliminada'**
  String get accountDeleted;

  /// No description provided for @delete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// No description provided for @activityTitle.
  ///
  /// In es, this message translates to:
  /// **'Mi Actividad'**
  String get activityTitle;

  /// No description provided for @noTripsYet.
  ///
  /// In es, this message translates to:
  /// **'Sin viajes aún'**
  String get noTripsYet;

  /// No description provided for @noTripsDescription.
  ///
  /// In es, this message translates to:
  /// **'Cuando completes tu primer viaje, aparecerá aquí'**
  String get noTripsDescription;

  /// No description provided for @tripStatusCompleted.
  ///
  /// In es, this message translates to:
  /// **'Completado'**
  String get tripStatusCompleted;

  /// No description provided for @tripStatusCancelled.
  ///
  /// In es, this message translates to:
  /// **'Cancelado'**
  String get tripStatusCancelled;

  /// No description provided for @tripStatusPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get tripStatusPending;

  /// No description provided for @tripStatusAssigned.
  ///
  /// In es, this message translates to:
  /// **'Asignado'**
  String get tripStatusAssigned;

  /// No description provided for @tripStatusInProgress.
  ///
  /// In es, this message translates to:
  /// **'En progreso'**
  String get tripStatusInProgress;

  /// No description provided for @tripStatusAccepted.
  ///
  /// In es, this message translates to:
  /// **'Aceptado'**
  String get tripStatusAccepted;

  /// No description provided for @tripStatusRequested.
  ///
  /// In es, this message translates to:
  /// **'Solicitado'**
  String get tripStatusRequested;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In es, this message translates to:
  /// **'RECUPERAR CONTRASEÑA'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordEmailHint.
  ///
  /// In es, this message translates to:
  /// **'Ingresa tu correo electrónico...'**
  String get forgotPasswordEmailHint;

  /// No description provided for @sendLink.
  ///
  /// In es, this message translates to:
  /// **'Enviar Enlace'**
  String get sendLink;

  /// No description provided for @backToLogin.
  ///
  /// In es, this message translates to:
  /// **'Volver a Iniciar Sesión'**
  String get backToLogin;

  /// No description provided for @emailSentTitle.
  ///
  /// In es, this message translates to:
  /// **'¡CORREO ENVIADO!'**
  String get emailSentTitle;

  /// No description provided for @emailSentMessage.
  ///
  /// In es, this message translates to:
  /// **'Hemos enviado un enlace de recuperación a:'**
  String get emailSentMessage;

  /// No description provided for @checkInboxMessage.
  ///
  /// In es, this message translates to:
  /// **'Revisa tu bandeja de entrada...'**
  String get checkInboxMessage;

  /// No description provided for @resendEmailLink.
  ///
  /// In es, this message translates to:
  /// **'¿No recibiste el correo? Intentar de nuevo'**
  String get resendEmailLink;

  /// No description provided for @loginHeroText.
  ///
  /// In es, this message translates to:
  /// **'MOVILIDAD DE ALTO NIVEL\nCON SEGURIDAD TOTAL.'**
  String get loginHeroText;

  /// No description provided for @loginTitle.
  ///
  /// In es, this message translates to:
  /// **'INICIA SESIÓN'**
  String get loginTitle;

  /// No description provided for @loginEmailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo Electrónico Corporativo o Personal*'**
  String get loginEmailLabel;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contraseña*'**
  String get loginPasswordLabel;

  /// No description provided for @forgotPasswordLink.
  ///
  /// In es, this message translates to:
  /// **'¿Has olvidado tu contraseña?'**
  String get forgotPasswordLink;

  /// No description provided for @loginButton.
  ///
  /// In es, this message translates to:
  /// **'Iniciar Sesión'**
  String get loginButton;

  /// No description provided for @registerLink.
  ///
  /// In es, this message translates to:
  /// **'¿Eres nuevo en BlinCar? ¡Inscríbete!'**
  String get registerLink;

  /// No description provided for @orDivider.
  ///
  /// In es, this message translates to:
  /// **'o'**
  String get orDivider;

  /// No description provided for @continueWithApple.
  ///
  /// In es, this message translates to:
  /// **'Continuar con Apple'**
  String get continueWithApple;

  /// No description provided for @continueWithGoogle.
  ///
  /// In es, this message translates to:
  /// **'Continuar con Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithFacebook.
  ///
  /// In es, this message translates to:
  /// **'Continuar con Facebook'**
  String get continueWithFacebook;

  /// No description provided for @facebookComingSoon.
  ///
  /// In es, this message translates to:
  /// **'Facebook Sign In próximamente'**
  String get facebookComingSoon;

  /// No description provided for @registerTitle.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Completa la información para registrarte'**
  String get registerSubtitle;

  /// No description provided for @accountTypeLabel.
  ///
  /// In es, this message translates to:
  /// **'Tipo de cuenta'**
  String get accountTypeLabel;

  /// No description provided for @passengerType.
  ///
  /// In es, this message translates to:
  /// **'Pasajero'**
  String get passengerType;

  /// No description provided for @driverType.
  ///
  /// In es, this message translates to:
  /// **'Conductor'**
  String get driverType;

  /// No description provided for @nameHint.
  ///
  /// In es, this message translates to:
  /// **'Tu nombre'**
  String get nameHint;

  /// No description provided for @lastNameHint.
  ///
  /// In es, this message translates to:
  /// **'Tus apellidos'**
  String get lastNameHint;

  /// No description provided for @emailHint.
  ///
  /// In es, this message translates to:
  /// **'tu@email.com'**
  String get emailHint;

  /// No description provided for @termsRequiredError.
  ///
  /// In es, this message translates to:
  /// **'Debes aceptar los términos y condiciones'**
  String get termsRequiredError;

  /// No description provided for @privacyRequiredError.
  ///
  /// In es, this message translates to:
  /// **'Debes aceptar la política de privacidad'**
  String get privacyRequiredError;

  /// No description provided for @ineRequiredError.
  ///
  /// In es, this message translates to:
  /// **'Debes cargar ambos lados de tu INE'**
  String get ineRequiredError;

  /// No description provided for @documentsUploaded.
  ///
  /// In es, this message translates to:
  /// **'Documentos subidos correctamente'**
  String get documentsUploaded;

  /// No description provided for @ineLabel.
  ///
  /// In es, this message translates to:
  /// **'Identificación Oficial (INE)'**
  String get ineLabel;

  /// No description provided for @ineDescription.
  ///
  /// In es, this message translates to:
  /// **'Sube fotos claras de tu INE'**
  String get ineDescription;

  /// No description provided for @ineFront.
  ///
  /// In es, this message translates to:
  /// **'Anverso (Frente)'**
  String get ineFront;

  /// No description provided for @ineFrontDescription.
  ///
  /// In es, this message translates to:
  /// **'Foto con tu nombre y fotografía'**
  String get ineFrontDescription;

  /// No description provided for @ineBack.
  ///
  /// In es, this message translates to:
  /// **'Reverso (Atrás)'**
  String get ineBack;

  /// No description provided for @ineBackDescription.
  ///
  /// In es, this message translates to:
  /// **'Foto con el código de barras'**
  String get ineBackDescription;

  /// No description provided for @securityNotice.
  ///
  /// In es, this message translates to:
  /// **'Tu información está protegida y encriptada'**
  String get securityNotice;

  /// No description provided for @uploadingDocuments.
  ///
  /// In es, this message translates to:
  /// **'Subiendo documentos...'**
  String get uploadingDocuments;

  /// No description provided for @createAccountButton.
  ///
  /// In es, this message translates to:
  /// **'Crear Cuenta'**
  String get createAccountButton;

  /// No description provided for @helpTitle.
  ///
  /// In es, this message translates to:
  /// **'Ayuda y Soporte'**
  String get helpTitle;

  /// No description provided for @faqSearchHint.
  ///
  /// In es, this message translates to:
  /// **'Buscar en preguntas frecuentes...'**
  String get faqSearchHint;

  /// No description provided for @faqTitle.
  ///
  /// In es, this message translates to:
  /// **'Preguntas Frecuentes'**
  String get faqTitle;

  /// No description provided for @noSearchResults.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron resultados'**
  String get noSearchResults;

  /// No description provided for @contactSupport.
  ///
  /// In es, this message translates to:
  /// **'Contactar soporte'**
  String get contactSupport;

  /// No description provided for @helloName.
  ///
  /// In es, this message translates to:
  /// **'Hola, {name}'**
  String helloName(String name);

  /// No description provided for @transportServices.
  ///
  /// In es, this message translates to:
  /// **'Servicios de Transporte'**
  String get transportServices;

  /// No description provided for @byRoute.
  ///
  /// In es, this message translates to:
  /// **'Por Ruta'**
  String get byRoute;

  /// No description provided for @predefinedRoutes.
  ///
  /// In es, this message translates to:
  /// **'Rutas predefinidas'**
  String get predefinedRoutes;

  /// No description provided for @byDay.
  ///
  /// In es, this message translates to:
  /// **'Por Día'**
  String get byDay;

  /// No description provided for @fullService.
  ///
  /// In es, this message translates to:
  /// **'Servicio completo'**
  String get fullService;

  /// No description provided for @customizeTrip.
  ///
  /// In es, this message translates to:
  /// **'Personaliza tu Viaje'**
  String get customizeTrip;

  /// No description provided for @originDestinationManual.
  ///
  /// In es, this message translates to:
  /// **'Ingresa origen y destino manualmente'**
  String get originDestinationManual;

  /// No description provided for @quickTrip.
  ///
  /// In es, this message translates to:
  /// **'Viaje Rápido'**
  String get quickTrip;

  /// No description provided for @wherePickup.
  ///
  /// In es, this message translates to:
  /// **'¿Dónde te recogemos?'**
  String get wherePickup;

  /// No description provided for @whereGoing.
  ///
  /// In es, this message translates to:
  /// **'¿A dónde vas?'**
  String get whereGoing;

  /// No description provided for @serviceTypeLabel.
  ///
  /// In es, this message translates to:
  /// **'Tipo de servicio'**
  String get serviceTypeLabel;

  /// No description provided for @scheduleLater.
  ///
  /// In es, this message translates to:
  /// **'Programar para más tarde'**
  String get scheduleLater;

  /// No description provided for @changeButton.
  ///
  /// In es, this message translates to:
  /// **'Cambiar'**
  String get changeButton;

  /// No description provided for @panicActivateConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de activar el botón de pánico? Se enviará una alerta inmediata.'**
  String get panicActivateConfirm;

  /// No description provided for @activateButton.
  ///
  /// In es, this message translates to:
  /// **'Activar'**
  String get activateButton;

  /// No description provided for @byDayServiceTitle.
  ///
  /// In es, this message translates to:
  /// **'Servicio Por Día'**
  String get byDayServiceTitle;

  /// No description provided for @comingSoon.
  ///
  /// In es, this message translates to:
  /// **'Próximamente disponible'**
  String get comingSoon;

  /// No description provided for @byDayDescription.
  ///
  /// In es, this message translates to:
  /// **'El servicio por día te permitirá contratar un conductor por tiempo completo'**
  String get byDayDescription;

  /// No description provided for @hoursService.
  ///
  /// In es, this message translates to:
  /// **'8 horas de servicio'**
  String get hoursService;

  /// No description provided for @multipleDestinations.
  ///
  /// In es, this message translates to:
  /// **'Múltiples destinos'**
  String get multipleDestinations;

  /// No description provided for @dedicatedDriver.
  ///
  /// In es, this message translates to:
  /// **'Conductor dedicado'**
  String get dedicatedDriver;

  /// No description provided for @understood.
  ///
  /// In es, this message translates to:
  /// **'Entendido'**
  String get understood;

  /// No description provided for @selectOrigin.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar origen'**
  String get selectOrigin;

  /// No description provided for @selectDestination.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar destino'**
  String get selectDestination;

  /// No description provided for @calculatingRoute.
  ///
  /// In es, this message translates to:
  /// **'Calculando ruta...'**
  String get calculatingRoute;

  /// No description provided for @totalToPay.
  ///
  /// In es, this message translates to:
  /// **'Total a pagar'**
  String get totalToPay;

  /// No description provided for @continuePayment.
  ///
  /// In es, this message translates to:
  /// **'Continuar al pago'**
  String get continuePayment;

  /// No description provided for @todayAt.
  ///
  /// In es, this message translates to:
  /// **'Hoy a las {time}'**
  String todayAt(String time);

  /// No description provided for @tomorrowAt.
  ///
  /// In es, this message translates to:
  /// **'Mañana a las {time}'**
  String tomorrowAt(String time);

  /// No description provided for @minimumScheduling.
  ///
  /// In es, this message translates to:
  /// **'El viaje debe agendarse con al menos 30 minutos de anticipación'**
  String get minimumScheduling;

  /// No description provided for @activityTab.
  ///
  /// In es, this message translates to:
  /// **'Actividad'**
  String get activityTab;

  /// No description provided for @profileTab.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get profileTab;

  /// No description provided for @passengerLabel.
  ///
  /// In es, this message translates to:
  /// **'Pasajero'**
  String get passengerLabel;

  /// No description provided for @mexicoOnly.
  ///
  /// In es, this message translates to:
  /// **'Solo se permiten destinos dentro de México'**
  String get mexicoOnly;

  /// No description provided for @searching.
  ///
  /// In es, this message translates to:
  /// **'Buscando...'**
  String get searching;

  /// No description provided for @loadingAddress.
  ///
  /// In es, this message translates to:
  /// **'Cargando dirección...'**
  String get loadingAddress;

  /// No description provided for @originPoint.
  ///
  /// In es, this message translates to:
  /// **'Punto de origen'**
  String get originPoint;

  /// No description provided for @destinationPoint.
  ///
  /// In es, this message translates to:
  /// **'Punto de destino'**
  String get destinationPoint;

  /// No description provided for @tapMap.
  ///
  /// In es, this message translates to:
  /// **'Toca el mapa para seleccionar'**
  String get tapMap;

  /// No description provided for @confirmOrigin.
  ///
  /// In es, this message translates to:
  /// **'Confirmar origen'**
  String get confirmOrigin;

  /// No description provided for @confirmDestination.
  ///
  /// In es, this message translates to:
  /// **'Confirmar destino'**
  String get confirmDestination;

  /// No description provided for @whereFrom.
  ///
  /// In es, this message translates to:
  /// **'¿Desde dónde sales?'**
  String get whereFrom;

  /// No description provided for @selectLocationTitle.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar ubicación'**
  String get selectLocationTitle;

  /// No description provided for @markAllRead.
  ///
  /// In es, this message translates to:
  /// **'Marcar todas'**
  String get markAllRead;

  /// No description provided for @noNotifications.
  ///
  /// In es, this message translates to:
  /// **'No tienes notificaciones'**
  String get noNotifications;

  /// No description provided for @justNow.
  ///
  /// In es, this message translates to:
  /// **'Hace un momento'**
  String get justNow;

  /// No description provided for @paymentHistoryTitle.
  ///
  /// In es, this message translates to:
  /// **'Historial de Pagos'**
  String get paymentHistoryTitle;

  /// No description provided for @totalPaid.
  ///
  /// In es, this message translates to:
  /// **'Total pagado'**
  String get totalPaid;

  /// No description provided for @completedTransactions.
  ///
  /// In es, this message translates to:
  /// **'transacciones completadas'**
  String get completedTransactions;

  /// No description provided for @allFilter.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get allFilter;

  /// No description provided for @refundsFilter.
  ///
  /// In es, this message translates to:
  /// **'Reembolsos'**
  String get refundsFilter;

  /// No description provided for @pendingFilter.
  ///
  /// In es, this message translates to:
  /// **'Pendientes'**
  String get pendingFilter;

  /// No description provided for @noTransactions.
  ///
  /// In es, this message translates to:
  /// **'No hay transacciones'**
  String get noTransactions;

  /// No description provided for @errorLoadingHistory.
  ///
  /// In es, this message translates to:
  /// **'Error al cargar historial'**
  String get errorLoadingHistory;

  /// No description provided for @statusFailed.
  ///
  /// In es, this message translates to:
  /// **'Fallido'**
  String get statusFailed;

  /// No description provided for @statusRefunded.
  ///
  /// In es, this message translates to:
  /// **'Reembolsado'**
  String get statusRefunded;

  /// No description provided for @refreshButton.
  ///
  /// In es, this message translates to:
  /// **'Actualizar'**
  String get refreshButton;

  /// No description provided for @personalDocs.
  ///
  /// In es, this message translates to:
  /// **'Personal'**
  String get personalDocs;

  /// No description provided for @licenseDocs.
  ///
  /// In es, this message translates to:
  /// **'Licencia'**
  String get licenseDocs;

  /// No description provided for @vehicleDocs.
  ///
  /// In es, this message translates to:
  /// **'Vehículo'**
  String get vehicleDocs;

  /// No description provided for @insuranceDocs.
  ///
  /// In es, this message translates to:
  /// **'Seguros'**
  String get insuranceDocs;

  /// No description provided for @docApproved.
  ///
  /// In es, this message translates to:
  /// **'Aprobado'**
  String get docApproved;

  /// No description provided for @docRejected.
  ///
  /// In es, this message translates to:
  /// **'Rechazado'**
  String get docRejected;

  /// No description provided for @docExpired.
  ///
  /// In es, this message translates to:
  /// **'Vencido'**
  String get docExpired;

  /// No description provided for @docMissing.
  ///
  /// In es, this message translates to:
  /// **'Faltante'**
  String get docMissing;

  /// No description provided for @docPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get docPending;

  /// No description provided for @reupload.
  ///
  /// In es, this message translates to:
  /// **'Resubir'**
  String get reupload;

  /// No description provided for @viewDocument.
  ///
  /// In es, this message translates to:
  /// **'Ver Documento'**
  String get viewDocument;

  /// No description provided for @uploadNewDocument.
  ///
  /// In es, this message translates to:
  /// **'Subir Nuevo Documento'**
  String get uploadNewDocument;

  /// No description provided for @chooseUploadMethod.
  ///
  /// In es, this message translates to:
  /// **'Selecciona cómo quieres subir tu documento:'**
  String get chooseUploadMethod;

  /// No description provided for @selectFromGallery.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar de Galería'**
  String get selectFromGallery;

  /// No description provided for @personalInformation.
  ///
  /// In es, this message translates to:
  /// **'Información Personal'**
  String get personalInformation;

  /// No description provided for @changeProfilePhoto.
  ///
  /// In es, this message translates to:
  /// **'Cambiar foto de perfil'**
  String get changeProfilePhoto;

  /// No description provided for @takePhotoOption.
  ///
  /// In es, this message translates to:
  /// **'Tomar foto'**
  String get takePhotoOption;

  /// No description provided for @chooseGallery.
  ///
  /// In es, this message translates to:
  /// **'Elegir de galería'**
  String get chooseGallery;

  /// No description provided for @fullNameHint.
  ///
  /// In es, this message translates to:
  /// **'Tu nombre completo'**
  String get fullNameHint;

  /// No description provided for @phone10Digits.
  ///
  /// In es, this message translates to:
  /// **'10 dígitos'**
  String get phone10Digits;

  /// No description provided for @changeEmailSection.
  ///
  /// In es, this message translates to:
  /// **'Cambiar correo electrónico'**
  String get changeEmailSection;

  /// No description provided for @emailVerificationNotice.
  ///
  /// In es, this message translates to:
  /// **'Se enviará un correo de verificación...'**
  String get emailVerificationNotice;

  /// No description provided for @newEmail.
  ///
  /// In es, this message translates to:
  /// **'Nuevo correo electrónico'**
  String get newEmail;

  /// No description provided for @updateEmailButton.
  ///
  /// In es, this message translates to:
  /// **'Actualizar correo'**
  String get updateEmailButton;

  /// No description provided for @changePasswordSection.
  ///
  /// In es, this message translates to:
  /// **'Cambiar contraseña'**
  String get changePasswordSection;

  /// No description provided for @min8Chars.
  ///
  /// In es, this message translates to:
  /// **'Mínimo 8 caracteres'**
  String get min8Chars;

  /// No description provided for @repeatNewPassword.
  ///
  /// In es, this message translates to:
  /// **'Repite la nueva contraseña'**
  String get repeatNewPassword;

  /// No description provided for @passwordsMismatch.
  ///
  /// In es, this message translates to:
  /// **'Las contraseñas no coinciden'**
  String get passwordsMismatch;

  /// No description provided for @myReservations.
  ///
  /// In es, this message translates to:
  /// **'Mis Reservaciones'**
  String get myReservations;

  /// No description provided for @activeFilter.
  ///
  /// In es, this message translates to:
  /// **'Activas'**
  String get activeFilter;

  /// No description provided for @pastFilter.
  ///
  /// In es, this message translates to:
  /// **'Pasadas'**
  String get pastFilter;

  /// No description provided for @cancelledFilter.
  ///
  /// In es, this message translates to:
  /// **'Canceladas'**
  String get cancelledFilter;

  /// No description provided for @noReservations.
  ///
  /// In es, this message translates to:
  /// **'No tienes reservaciones'**
  String get noReservations;

  /// No description provided for @reservationDetails.
  ///
  /// In es, this message translates to:
  /// **'Detalles de Reservación'**
  String get reservationDetails;

  /// No description provided for @reservationId.
  ///
  /// In es, this message translates to:
  /// **'ID:'**
  String get reservationId;

  /// No description provided for @reservationConfirmed.
  ///
  /// In es, this message translates to:
  /// **'Confirmada'**
  String get reservationConfirmed;

  /// No description provided for @reservationCompleted.
  ///
  /// In es, this message translates to:
  /// **'Completada'**
  String get reservationCompleted;

  /// No description provided for @reservationCancelled.
  ///
  /// In es, this message translates to:
  /// **'Cancelada'**
  String get reservationCancelled;

  /// No description provided for @modifyButton.
  ///
  /// In es, this message translates to:
  /// **'Modificar'**
  String get modifyButton;

  /// No description provided for @cancelReservation.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancelReservation;

  /// No description provided for @notificationTypes.
  ///
  /// In es, this message translates to:
  /// **'Tipos de notificaciones'**
  String get notificationTypes;

  /// No description provided for @notifTrips.
  ///
  /// In es, this message translates to:
  /// **'Viajes'**
  String get notifTrips;

  /// No description provided for @notifPayments.
  ///
  /// In es, this message translates to:
  /// **'Pagos'**
  String get notifPayments;

  /// No description provided for @notifSecurity.
  ///
  /// In es, this message translates to:
  /// **'Seguridad'**
  String get notifSecurity;

  /// No description provided for @notifPromotions.
  ///
  /// In es, this message translates to:
  /// **'Promociones'**
  String get notifPromotions;

  /// No description provided for @soundVibration.
  ///
  /// In es, this message translates to:
  /// **'Sonido y vibración'**
  String get soundVibration;

  /// No description provided for @soundLabel.
  ///
  /// In es, this message translates to:
  /// **'Sonido'**
  String get soundLabel;

  /// No description provided for @soundDescription.
  ///
  /// In es, this message translates to:
  /// **'Reproducir sonido con las notificaciones'**
  String get soundDescription;

  /// No description provided for @vibrationLabel.
  ///
  /// In es, this message translates to:
  /// **'Vibración'**
  String get vibrationLabel;

  /// No description provided for @vibrationDescription.
  ///
  /// In es, this message translates to:
  /// **'Vibrar con las notificaciones'**
  String get vibrationDescription;

  /// No description provided for @doNotDisturb.
  ///
  /// In es, this message translates to:
  /// **'No molestar'**
  String get doNotDisturb;

  /// No description provided for @quietHours.
  ///
  /// In es, this message translates to:
  /// **'Horario de silencio'**
  String get quietHours;

  /// No description provided for @quietHoursDescription.
  ///
  /// In es, this message translates to:
  /// **'Silenciar notificaciones durante un horario'**
  String get quietHoursDescription;

  /// No description provided for @startTime.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In es, this message translates to:
  /// **'Fin'**
  String get endTime;

  /// No description provided for @securityAlertsAlways.
  ///
  /// In es, this message translates to:
  /// **'Las alertas de seguridad siempre se mostrarán'**
  String get securityAlertsAlways;

  /// No description provided for @notificationsEnabled.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones activas'**
  String get notificationsEnabled;

  /// No description provided for @notificationsDisabled.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones desactivadas'**
  String get notificationsDisabled;

  /// No description provided for @enableSystemNotifications.
  ///
  /// In es, this message translates to:
  /// **'Por favor habilita notificaciones en configuración del sistema'**
  String get enableSystemNotifications;

  /// No description provided for @importantLabel.
  ///
  /// In es, this message translates to:
  /// **'Importante'**
  String get importantLabel;

  /// No description provided for @enableButton.
  ///
  /// In es, this message translates to:
  /// **'Activar'**
  String get enableButton;

  /// No description provided for @confirmPaymentTitle.
  ///
  /// In es, this message translates to:
  /// **'Confirmar pago'**
  String get confirmPaymentTitle;

  /// No description provided for @selectPaymentMethod.
  ///
  /// In es, this message translates to:
  /// **'Selecciona un método de pago'**
  String get selectPaymentMethod;

  /// No description provided for @paymentInProgress.
  ///
  /// In es, this message translates to:
  /// **'Ya hay un pago en proceso'**
  String get paymentInProgress;

  /// No description provided for @additionalAuthRequired.
  ///
  /// In es, this message translates to:
  /// **'Se requiere autenticación adicional'**
  String get additionalAuthRequired;

  /// No description provided for @paymentRejected.
  ///
  /// In es, this message translates to:
  /// **'Pago rechazado:'**
  String get paymentRejected;

  /// No description provided for @paymentProcessingError.
  ///
  /// In es, this message translates to:
  /// **'Error procesando el pago'**
  String get paymentProcessingError;

  /// No description provided for @paymentConfirmedStatus.
  ///
  /// In es, this message translates to:
  /// **'Pago confirmado'**
  String get paymentConfirmedStatus;

  /// No description provided for @paymentProcessed.
  ///
  /// In es, this message translates to:
  /// **'Se ha procesado el pago de'**
  String get paymentProcessed;

  /// No description provided for @lookingForDriver.
  ///
  /// In es, this message translates to:
  /// **'Buscar conductor'**
  String get lookingForDriver;

  /// No description provided for @addNewCard.
  ///
  /// In es, this message translates to:
  /// **'Agregar nueva tarjeta'**
  String get addNewCard;

  /// No description provided for @estimatedTime.
  ///
  /// In es, this message translates to:
  /// **'Tiempo estimado'**
  String get estimatedTime;

  /// No description provided for @paymentSecurityNotice.
  ///
  /// In es, this message translates to:
  /// **'Pago seguro. Tu información está protegida con encriptación de nivel bancario.'**
  String get paymentSecurityNotice;

  /// No description provided for @originLabel.
  ///
  /// In es, this message translates to:
  /// **'Origen'**
  String get originLabel;

  /// No description provided for @destinationLabel.
  ///
  /// In es, this message translates to:
  /// **'Destino'**
  String get destinationLabel;

  /// No description provided for @serviceLabel.
  ///
  /// In es, this message translates to:
  /// **'Servicio'**
  String get serviceLabel;

  /// No description provided for @allTrips.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get allTrips;

  /// No description provided for @completedTrips.
  ///
  /// In es, this message translates to:
  /// **'Completados'**
  String get completedTrips;

  /// No description provided for @cancelledTrips.
  ///
  /// In es, this message translates to:
  /// **'Cancelados'**
  String get cancelledTrips;

  /// No description provided for @noTripsDisplay.
  ///
  /// In es, this message translates to:
  /// **'No hay viajes para mostrar'**
  String get noTripsDisplay;

  /// No description provided for @selectRoute.
  ///
  /// In es, this message translates to:
  /// **'Selecciona tu ruta'**
  String get selectRoute;

  /// No description provided for @noRoutes.
  ///
  /// In es, this message translates to:
  /// **'No hay rutas disponibles'**
  String get noRoutes;

  /// No description provided for @reloadRoutes.
  ///
  /// In es, this message translates to:
  /// **'Recargar rutas'**
  String get reloadRoutes;

  /// No description provided for @changeRoute.
  ///
  /// In es, this message translates to:
  /// **'Cambiar ruta'**
  String get changeRoute;

  /// No description provided for @distanceLabel.
  ///
  /// In es, this message translates to:
  /// **'Distancia'**
  String get distanceLabel;

  /// No description provided for @servicePtp.
  ///
  /// In es, this message translates to:
  /// **'Punto a Punto'**
  String get servicePtp;

  /// No description provided for @serviceArmedEscort.
  ///
  /// In es, this message translates to:
  /// **'Con Escolta Armado'**
  String get serviceArmedEscort;

  /// No description provided for @serviceUnarmedEscort.
  ///
  /// In es, this message translates to:
  /// **'Con Escolta Desarmado'**
  String get serviceUnarmedEscort;

  /// No description provided for @serviceArmoredEscort.
  ///
  /// In es, this message translates to:
  /// **'Auto Blindado + Escolta'**
  String get serviceArmoredEscort;

  /// No description provided for @requestTripButton.
  ///
  /// In es, this message translates to:
  /// **'Solicitar viaje'**
  String get requestTripButton;

  /// No description provided for @includesTolls.
  ///
  /// In es, this message translates to:
  /// **'(incluye casetas)'**
  String get includesTolls;

  /// No description provided for @tripInProgressTitle.
  ///
  /// In es, this message translates to:
  /// **'Viaje en Curso'**
  String get tripInProgressTitle;

  /// No description provided for @tripCompletedTitle.
  ///
  /// In es, this message translates to:
  /// **'Viaje Completado'**
  String get tripCompletedTitle;

  /// No description provided for @tripSuccessMessage.
  ///
  /// In es, this message translates to:
  /// **'¡Tu viaje ha finalizado con éxito!'**
  String get tripSuccessMessage;

  /// No description provided for @totalLabel.
  ///
  /// In es, this message translates to:
  /// **'Total'**
  String get totalLabel;

  /// No description provided for @durationLabel.
  ///
  /// In es, this message translates to:
  /// **'Duración'**
  String get durationLabel;

  /// No description provided for @skipButton.
  ///
  /// In es, this message translates to:
  /// **'Omitir'**
  String get skipButton;

  /// No description provided for @rateTripButton.
  ///
  /// In es, this message translates to:
  /// **'Calificar viaje'**
  String get rateTripButton;

  /// No description provided for @exitTripTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Salir del viaje?'**
  String get exitTripTitle;

  /// No description provided for @exitTripMessage.
  ///
  /// In es, this message translates to:
  /// **'Tu viaje está en curso. ¿Estás seguro de que quieres salir? Podrás regresar desde la página principal.'**
  String get exitTripMessage;

  /// No description provided for @exitButton.
  ///
  /// In es, this message translates to:
  /// **'Salir'**
  String get exitButton;

  /// No description provided for @phoneNotAvailable.
  ///
  /// In es, this message translates to:
  /// **'Número de teléfono no disponible'**
  String get phoneNotAvailable;

  /// No description provided for @cannotMakeCall.
  ///
  /// In es, this message translates to:
  /// **'No se puede realizar la llamada'**
  String get cannotMakeCall;

  /// No description provided for @errorLoadingTrip.
  ///
  /// In es, this message translates to:
  /// **'Error al cargar el viaje'**
  String get errorLoadingTrip;

  /// No description provided for @onlyDriverFinish.
  ///
  /// In es, this message translates to:
  /// **'Solo el conductor puede finalizar el viaje'**
  String get onlyDriverFinish;

  /// No description provided for @waitingFinish.
  ///
  /// In es, this message translates to:
  /// **'Esperando finalización'**
  String get waitingFinish;

  /// No description provided for @panicButtonLabel.
  ///
  /// In es, this message translates to:
  /// **'PÁNICO'**
  String get panicButtonLabel;

  /// No description provided for @vehicleTypeLabel.
  ///
  /// In es, this message translates to:
  /// **'Suburban Ejecutiva'**
  String get vehicleTypeLabel;

  /// No description provided for @waitingTitle.
  ///
  /// In es, this message translates to:
  /// **'Esperando asignación'**
  String get waitingTitle;

  /// No description provided for @driverAssignedTitle.
  ///
  /// In es, this message translates to:
  /// **'¡Conductor asignado!'**
  String get driverAssignedTitle;

  /// No description provided for @driverOnWay.
  ///
  /// In es, this message translates to:
  /// **'Tu conductor está en camino'**
  String get driverOnWay;

  /// No description provided for @vehicleLabel.
  ///
  /// In es, this message translates to:
  /// **'Vehículo'**
  String get vehicleLabel;

  /// No description provided for @viewTrip.
  ///
  /// In es, this message translates to:
  /// **'Ver viaje'**
  String get viewTrip;

  /// No description provided for @tripCancelledTitle.
  ///
  /// In es, this message translates to:
  /// **'Viaje cancelado'**
  String get tripCancelledTitle;

  /// No description provided for @tripCancelledMessage.
  ///
  /// In es, this message translates to:
  /// **'Tu viaje ha sido cancelado.'**
  String get tripCancelledMessage;

  /// No description provided for @tripDetails.
  ///
  /// In es, this message translates to:
  /// **'Detalles del viaje'**
  String get tripDetails;

  /// No description provided for @routeLabel.
  ///
  /// In es, this message translates to:
  /// **'Ruta'**
  String get routeLabel;

  /// No description provided for @priceLabel.
  ///
  /// In es, this message translates to:
  /// **'Precio'**
  String get priceLabel;

  /// No description provided for @requestedLabel.
  ///
  /// In es, this message translates to:
  /// **'Solicitado'**
  String get requestedLabel;

  /// No description provided for @cancelTripButton.
  ///
  /// In es, this message translates to:
  /// **'Cancelar viaje'**
  String get cancelTripButton;

  /// No description provided for @stayButton.
  ///
  /// In es, this message translates to:
  /// **'Quedarme'**
  String get stayButton;

  /// No description provided for @exitAssignmentMessage.
  ///
  /// In es, this message translates to:
  /// **'Tu viaje sigue en proceso de asignación. ¿Deseas salir?'**
  String get exitAssignmentMessage;

  /// No description provided for @cancelTripConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que deseas cancelar este viaje?'**
  String get cancelTripConfirm;

  /// No description provided for @yesCancel.
  ///
  /// In es, this message translates to:
  /// **'Sí, cancelar'**
  String get yesCancel;

  /// No description provided for @driverLabel.
  ///
  /// In es, this message translates to:
  /// **'Conductor'**
  String get driverLabel;

  /// No description provided for @useDeviceCamera.
  ///
  /// In es, this message translates to:
  /// **'Usar la cámara del dispositivo'**
  String get useDeviceCamera;

  /// No description provided for @acceptTermsPrefix.
  ///
  /// In es, this message translates to:
  /// **'Acepto los '**
  String get acceptTermsPrefix;

  /// No description provided for @termsLink.
  ///
  /// In es, this message translates to:
  /// **'términos y condiciones'**
  String get termsLink;

  /// No description provided for @acceptPrivacyPrefix.
  ///
  /// In es, this message translates to:
  /// **'Acepto la '**
  String get acceptPrivacyPrefix;

  /// No description provided for @privacyLink.
  ///
  /// In es, this message translates to:
  /// **'política de privacidad'**
  String get privacyLink;

  /// No description provided for @errorUploadingDocs.
  ///
  /// In es, this message translates to:
  /// **'Error subiendo documentos: {error}'**
  String errorUploadingDocs(String error);

  /// No description provided for @paymentConfirmed.
  ///
  /// In es, this message translates to:
  /// **'Pago confirmado'**
  String get paymentConfirmed;

  /// No description provided for @paymentProcessedMessage.
  ///
  /// In es, this message translates to:
  /// **'Se ha procesado el pago de {amount}'**
  String paymentProcessedMessage(String amount);

  /// No description provided for @confirmPayment.
  ///
  /// In es, this message translates to:
  /// **'Confirmar pago'**
  String get confirmPayment;

  /// No description provided for @noSavedCards.
  ///
  /// In es, this message translates to:
  /// **'Sin tarjetas guardadas'**
  String get noSavedCards;

  /// No description provided for @addCardToContinue.
  ///
  /// In es, this message translates to:
  /// **'Agrega una tarjeta para continuar'**
  String get addCardToContinue;

  /// No description provided for @processingPayment.
  ///
  /// In es, this message translates to:
  /// **'Procesando pago...'**
  String get processingPayment;

  /// No description provided for @retryingPayment.
  ///
  /// In es, this message translates to:
  /// **'Reintentando...'**
  String get retryingPayment;

  /// No description provided for @confirmingPayment.
  ///
  /// In es, this message translates to:
  /// **'Confirmando pago...'**
  String get confirmingPayment;

  /// No description provided for @paymentCompleted.
  ///
  /// In es, this message translates to:
  /// **'Pago completado'**
  String get paymentCompleted;

  /// No description provided for @retryPayment.
  ///
  /// In es, this message translates to:
  /// **'Reintentar pago'**
  String get retryPayment;

  /// No description provided for @payAmount.
  ///
  /// In es, this message translates to:
  /// **'Pagar \${amount}'**
  String payAmount(String amount);

  /// No description provided for @securePaymentNote.
  ///
  /// In es, this message translates to:
  /// **'Pago seguro. Tu información está protegida con encriptación de nivel bancario.'**
  String get securePaymentNote;

  /// No description provided for @cardExpires.
  ///
  /// In es, this message translates to:
  /// **'Vence {date}'**
  String cardExpires(String date);

  /// No description provided for @defaultCard.
  ///
  /// In es, this message translates to:
  /// **'Principal'**
  String get defaultCard;

  /// No description provided for @minutesAgo.
  ///
  /// In es, this message translates to:
  /// **'Hace {minutes} min'**
  String minutesAgo(int minutes);

  /// No description provided for @exitTitle.
  ///
  /// In es, this message translates to:
  /// **'Salir'**
  String get exitTitle;

  /// No description provided for @cancelTripConfirmMessage.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que deseas cancelar este viaje?'**
  String get cancelTripConfirmMessage;

  /// No description provided for @noButton.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get noButton;

  /// No description provided for @yesCancelButton.
  ///
  /// In es, this message translates to:
  /// **'Sí, cancelar'**
  String get yesCancelButton;

  /// No description provided for @tripCompletedMessage.
  ///
  /// In es, this message translates to:
  /// **'¡Tu viaje ha finalizado con éxito!'**
  String get tripCompletedMessage;

  /// No description provided for @onlyDriverCanEnd.
  ///
  /// In es, this message translates to:
  /// **'Solo el conductor puede finalizar el viaje'**
  String get onlyDriverCanEnd;

  /// No description provided for @waitingCompletion.
  ///
  /// In es, this message translates to:
  /// **'Esperando finalización'**
  String get waitingCompletion;

  /// No description provided for @statusInProgress.
  ///
  /// In es, this message translates to:
  /// **'En Curso'**
  String get statusInProgress;

  /// No description provided for @statusPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get statusPending;

  /// No description provided for @statusAssigned.
  ///
  /// In es, this message translates to:
  /// **'Asignado'**
  String get statusAssigned;

  /// No description provided for @availableRoutes.
  ///
  /// In es, this message translates to:
  /// **'Rutas Disponibles ({count})'**
  String availableRoutes(int count);

  /// No description provided for @selectYourRoute.
  ///
  /// In es, this message translates to:
  /// **'Selecciona tu ruta'**
  String get selectYourRoute;

  /// No description provided for @noRoutesAvailable.
  ///
  /// In es, this message translates to:
  /// **'No hay rutas disponibles'**
  String get noRoutesAvailable;

  /// No description provided for @checkConsoleDetails.
  ///
  /// In es, this message translates to:
  /// **'Revisa la consola para más detalles'**
  String get checkConsoleDetails;

  /// No description provided for @minutes.
  ///
  /// In es, this message translates to:
  /// **'minutos'**
  String get minutes;

  /// No description provided for @serviceType.
  ///
  /// In es, this message translates to:
  /// **'Tipo de servicio'**
  String get serviceType;

  /// No description provided for @mustLogin.
  ///
  /// In es, this message translates to:
  /// **'Debes iniciar sesión'**
  String get mustLogin;

  /// No description provided for @byRouteTitle.
  ///
  /// In es, this message translates to:
  /// **'Por Ruta'**
  String get byRouteTitle;

  /// No description provided for @byRouteSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Rutas predefinidas'**
  String get byRouteSubtitle;

  /// No description provided for @byDayTitle.
  ///
  /// In es, this message translates to:
  /// **'Por Día'**
  String get byDayTitle;

  /// No description provided for @byDaySubtitle.
  ///
  /// In es, this message translates to:
  /// **'Servicio completo'**
  String get byDaySubtitle;

  /// No description provided for @customTripTitle.
  ///
  /// In es, this message translates to:
  /// **'Personaliza tu Viaje'**
  String get customTripTitle;

  /// No description provided for @customTripSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Ingresa origen y destino manualmente'**
  String get customTripSubtitle;

  /// No description provided for @navHome.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// No description provided for @navRoutes.
  ///
  /// In es, this message translates to:
  /// **'Rutas'**
  String get navRoutes;

  /// No description provided for @navActivity.
  ///
  /// In es, this message translates to:
  /// **'Actividad'**
  String get navActivity;

  /// No description provided for @navProfile.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get navProfile;

  /// No description provided for @scheduleForLater.
  ///
  /// In es, this message translates to:
  /// **'Programar para más tarde'**
  String get scheduleForLater;

  /// No description provided for @selectOriginDestination.
  ///
  /// In es, this message translates to:
  /// **'Selecciona origen y destino'**
  String get selectOriginDestination;

  /// No description provided for @errorPrefix.
  ///
  /// In es, this message translates to:
  /// **'Error'**
  String get errorPrefix;

  /// No description provided for @scheduleMinTime.
  ///
  /// In es, this message translates to:
  /// **'El viaje debe agendarse con al menos 30 minutos de anticipación'**
  String get scheduleMinTime;

  /// No description provided for @panicDialogTitle.
  ///
  /// In es, this message translates to:
  /// **'Botón de Pánico'**
  String get panicDialogTitle;

  /// No description provided for @panicDialogMessage.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de activar el botón de pánico? Se enviará una alerta inmediata.'**
  String get panicDialogMessage;

  /// No description provided for @continueToPay.
  ///
  /// In es, this message translates to:
  /// **'Continuar al pago'**
  String get continueToPay;

  /// No description provided for @passengerRole.
  ///
  /// In es, this message translates to:
  /// **'Pasajero'**
  String get passengerRole;

  /// No description provided for @onlyMexicoDestinations.
  ///
  /// In es, this message translates to:
  /// **'Solo se permiten destinos dentro de México'**
  String get onlyMexicoDestinations;

  /// No description provided for @tapMapToSelect.
  ///
  /// In es, this message translates to:
  /// **'Toca el mapa para seleccionar'**
  String get tapMapToSelect;

  /// No description provided for @personalDocsTitle.
  ///
  /// In es, this message translates to:
  /// **'Documentos Personales'**
  String get personalDocsTitle;

  /// No description provided for @personalDocsDescription.
  ///
  /// In es, this message translates to:
  /// **'Identificación oficial vigente requerida para el servicio'**
  String get personalDocsDescription;

  /// No description provided for @notifTripsDescription.
  ///
  /// In es, this message translates to:
  /// **'Actualizaciones sobre el estado de tus viajes'**
  String get notifTripsDescription;

  /// No description provided for @notifPaymentsDescription.
  ///
  /// In es, this message translates to:
  /// **'Confirmaciones y recibos de pago'**
  String get notifPaymentsDescription;

  /// No description provided for @notifSecurityDescription.
  ///
  /// In es, this message translates to:
  /// **'Alertas importantes de seguridad y cuenta'**
  String get notifSecurityDescription;

  /// No description provided for @notifPromotionsDescription.
  ///
  /// In es, this message translates to:
  /// **'Ofertas y descuentos especiales'**
  String get notifPromotionsDescription;

  /// No description provided for @notificationsEnabledDesc.
  ///
  /// In es, this message translates to:
  /// **'Recibirás notificaciones de Blincar'**
  String get notificationsEnabledDesc;

  /// No description provided for @changeLabel.
  ///
  /// In es, this message translates to:
  /// **'Cambiar'**
  String get changeLabel;

  /// No description provided for @scheduleMinimumTime.
  ///
  /// In es, this message translates to:
  /// **'El viaje debe agendarse con al menos 30 minutos de anticipación'**
  String get scheduleMinimumTime;

  /// No description provided for @activate.
  ///
  /// In es, this message translates to:
  /// **'Activar'**
  String get activate;

  /// No description provided for @loginRequired.
  ///
  /// In es, this message translates to:
  /// **'Debes iniciar sesión'**
  String get loginRequired;

  /// No description provided for @serviceTypePtoP.
  ///
  /// In es, this message translates to:
  /// **'Punto a Punto'**
  String get serviceTypePtoP;

  /// No description provided for @serviceTypeArmedEscort.
  ///
  /// In es, this message translates to:
  /// **'Con Escolta Armado'**
  String get serviceTypeArmedEscort;

  /// No description provided for @serviceTypeUnarmedEscort.
  ///
  /// In es, this message translates to:
  /// **'Con Escolta Desarmado'**
  String get serviceTypeUnarmedEscort;

  /// No description provided for @serviceTypeArmored.
  ///
  /// In es, this message translates to:
  /// **'Auto Blindado'**
  String get serviceTypeArmored;

  /// No description provided for @serviceTypeArmoredEscort.
  ///
  /// In es, this message translates to:
  /// **'Auto Blindado + Escolta'**
  String get serviceTypeArmoredEscort;

  /// No description provided for @byDayComingSoon.
  ///
  /// In es, this message translates to:
  /// **'El servicio por día te permitirá contratar un conductor y vehículo durante un día completo para múltiples traslados.'**
  String get byDayComingSoon;

  /// No description provided for @tripsCompleted.
  ///
  /// In es, this message translates to:
  /// **'Viajes completados'**
  String get tripsCompleted;

  /// No description provided for @totalSpent.
  ///
  /// In es, this message translates to:
  /// **'Total gastado'**
  String get totalSpent;

  /// No description provided for @registerLinkPrefix.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes cuenta? '**
  String get registerLinkPrefix;

  /// No description provided for @registerLinkAction.
  ///
  /// In es, this message translates to:
  /// **'Regístrate'**
  String get registerLinkAction;

  /// No description provided for @supportDescription.
  ///
  /// In es, this message translates to:
  /// **'Nuestro equipo de soporte está disponible las 24 horas para ayudarte'**
  String get supportDescription;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
