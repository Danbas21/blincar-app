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
