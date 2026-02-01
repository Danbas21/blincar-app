// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Blincar';

  @override
  String get welcome => 'Bienvenido a Blincar';

  @override
  String get login => 'Iniciar Sesión';

  @override
  String get register => 'Registrarse';

  @override
  String get email => 'Correo Electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get firstName => 'Nombre';

  @override
  String get lastName => 'Apellidos';

  @override
  String get phone => 'Teléfono';

  @override
  String get emergencyContact => 'Contacto de Emergencia';

  @override
  String get emergencyContactPhone => 'Teléfono de Emergencia';

  @override
  String get requestTrip => 'Solicitar Viaje';

  @override
  String get tripNow => 'Viaje Ahora';

  @override
  String get tripByHour => 'Viaje por Hora';

  @override
  String get tripByDay => 'Viaje por Días';

  @override
  String get carWithDriver => 'Auto con Chofer';

  @override
  String get armoredCar => 'Auto Blindado';

  @override
  String get armedEscort => 'Auto con Escolta Armado';

  @override
  String get unarmedEscort => 'Auto con Escolta Desarmado';

  @override
  String get panicButton => 'Botón de Pánico';

  @override
  String get myAccount => 'Mi Cuenta';

  @override
  String get activity => 'Actividad';

  @override
  String get wallet => 'Billetera';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get settings => 'Configuración';

  @override
  String get profile => 'Perfil';

  @override
  String get paymentMethods => 'Métodos de Pago';

  @override
  String get tripHistory => 'Historial de Viajes';

  @override
  String get earnings => 'Ganancias';

  @override
  String get documentation => 'Documentación';

  @override
  String get verification => 'Verificación';

  @override
  String get uploadDocument => 'Subir Documento';

  @override
  String get takePhoto => 'Tomar Foto';

  @override
  String get pickFromGallery => 'Seleccionar de Galería';

  @override
  String get driverLicense => 'Licencia de Conducir';

  @override
  String get vehicleRegistration => 'Registro del Vehículo';

  @override
  String get insurance => 'Seguro';

  @override
  String get backgroundCheck => 'Verificación de Antecedentes';

  @override
  String get startTrip => 'Iniciar Viaje';

  @override
  String get endTrip => 'Finalizar Viaje';

  @override
  String get cancelTrip => 'Cancelar Viaje';

  @override
  String get rateTrip => 'Calificar Viaje';

  @override
  String get paymentSuccessful => 'Pago Exitoso';

  @override
  String get paymentFailed => 'Pago No Realizado';

  @override
  String get cashPayment => 'Pago en Efectivo';

  @override
  String get cardPayment => 'Pago con Tarjeta';

  @override
  String get routeChangeRequest => 'Solicitud de Cambio de Ruta';

  @override
  String get approveRouteChange => 'Aprobar Cambio';

  @override
  String get rejectRouteChange => 'Rechazar Cambio';

  @override
  String emergencyContactMessage(String name) {
    return '$name requiere de tu apoyo y seguimiento';
  }

  @override
  String get monthlyEarnings => 'Ganancias Mensuales';

  @override
  String get totalTrips => 'Viajes Totales';

  @override
  String get rating => 'Calificación';

  @override
  String get available => 'Disponible';

  @override
  String get busy => 'Ocupado';

  @override
  String get offline => 'Desconectado';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get termsAndConditions => 'Términos y Condiciones';

  @override
  String get legalNotices => 'Avisos Legales';

  @override
  String get acceptTerms => 'Acepto los términos y condiciones';

  @override
  String get acceptPrivacyPolicy => 'Acepto la política de privacidad';

  @override
  String get currency => 'MXN';

  @override
  String get region => 'México';

  @override
  String get language => 'Idioma';

  @override
  String get languageSettings => 'Configuración de Idioma';

  @override
  String get selectLanguage => 'Seleccionar Idioma';

  @override
  String get spanish => 'Español';

  @override
  String get english => 'Inglés';

  @override
  String get languageChanged => 'Idioma cambiado correctamente';

  @override
  String get systemLanguage => 'Idioma del sistema';

  @override
  String get useSystemLanguage => 'Usar idioma del dispositivo';

  @override
  String get currentLanguage => 'Idioma actual';

  @override
  String get changeLanguage => 'Cambiar idioma';

  @override
  String get languageDescription => 'Selecciona el idioma de la aplicación';

  @override
  String get editProfile => 'Editar Perfil';

  @override
  String get fullName => 'Nombre Completo';

  @override
  String get saveChanges => 'Guardar Cambios';

  @override
  String get updateEmail => 'Actualizar Correo';

  @override
  String get updatePassword => 'Actualizar Contraseña';

  @override
  String get currentPassword => 'Contraseña Actual';

  @override
  String get newPassword => 'Nueva Contraseña';

  @override
  String get confirmPassword => 'Confirmar Contraseña';

  @override
  String get profileUpdated => 'Perfil actualizado correctamente';

  @override
  String get passwordUpdated => 'Contraseña actualizada correctamente';

  @override
  String get changePhoto => 'Cambiar Foto';

  @override
  String get camera => 'Cámara';

  @override
  String get gallery => 'Galería';

  @override
  String get logout => 'Cerrar Sesión';

  @override
  String get logoutConfirmation => '¿Estás seguro de que deseas cerrar sesión?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get error => 'Error';

  @override
  String get success => 'Éxito';

  @override
  String get loading => 'Cargando...';

  @override
  String get retry => 'Reintentar';

  @override
  String get noData => 'Sin datos';

  @override
  String get home => 'Inicio';

  @override
  String get routes => 'Rutas';

  @override
  String get emergencyContactName => 'Nombre del Contacto';

  @override
  String get emergencyContactNameHint => 'Ej: María García';

  @override
  String get emergencyContactDescription =>
      'Este contacto será llamado automáticamente cuando actives el botón de pánico';

  @override
  String get emergencyContactRequired =>
      'Debes configurar un contacto de emergencia';

  @override
  String get nameRequired => 'El nombre es requerido';

  @override
  String get nameTooShort => 'El nombre debe tener al menos 2 caracteres';

  @override
  String get phoneRequired => 'El teléfono es requerido';

  @override
  String get phoneInvalid => 'Ingresa un número de teléfono válido';

  @override
  String get whenContacted => '¿Cuándo se contactará?';

  @override
  String get contactInfoPanic => 'Cuando actives el botón de pánico';

  @override
  String get contactInfoCall => 'Recibirá una llamada automática';

  @override
  String get contactInfoLocation => 'Se compartirá tu ubicación en tiempo real';

  @override
  String get contactInfoSms => 'Recibirá un SMS con información del viaje';

  @override
  String get configureEmergencyContact => 'Configurar contacto de emergencia';

  @override
  String get notConfigured => 'No configurado';

  @override
  String get panicTitle => 'Botón de Pánico';

  @override
  String get panicAlertActive => 'ALERTA ACTIVA';

  @override
  String get emergencySystem => 'Sistema de Emergencia';

  @override
  String get panicActivateInfo => 'Al activar el botón de pánico:';

  @override
  String get panicFeature1 => 'Se notifica a autoridades locales';

  @override
  String get panicFeature2 => 'Se contacta a tu contacto de emergencia';

  @override
  String get panicFeature3 => 'Se graba audio y video automáticamente';

  @override
  String get panicFeature4 => 'Se comparte tu ubicación en tiempo real';

  @override
  String get panicFeature5 => 'Se envía alerta a otros conductores cercanos';

  @override
  String get activatingAlertIn => 'ACTIVANDO ALERTA EN:';

  @override
  String get alertSent =>
      'ALERTA ENVIADA - Autoridades y contactos notificados';

  @override
  String get authoritiesNotified =>
      'Las autoridades han sido notificadas y están en camino';

  @override
  String get authoritiesNotifiedStatus => 'Autoridades notificadas';

  @override
  String get emergencyContactCalled => 'Contacto de emergencia llamado';

  @override
  String get recordingStarted => 'Grabación iniciada';

  @override
  String get locationShared => 'Ubicación compartida';

  @override
  String get nearbyDriversAlerted => 'Conductores cercanos alertados';

  @override
  String get deactivateAlert => 'DESACTIVAR ALERTA';

  @override
  String get deactivateOnlySafe => 'Solo desactiva si estás a salvo';

  @override
  String get emergencyContacts => 'Contactos de Emergencia';

  @override
  String get emergencies => 'Emergencias';

  @override
  String get support247 => 'Soporte 24/7';

  @override
  String callingContact(String name) {
    return 'Llamando a $name...';
  }

  @override
  String get callFailed => 'No se pudo realizar la llamada';

  @override
  String get noEmergencyContactConfigured =>
      'No tienes un contacto de emergencia configurado';

  @override
  String get confirmDeactivation => 'Confirmar desactivación';

  @override
  String get typeToConfirm => 'Escribe: ESTOY SEGURO';

  @override
  String get verifyPhone => 'Verifica tu teléfono';

  @override
  String get enterPhoneToVerify =>
      'Ingresa tu número de teléfono para recibir un código de verificación';

  @override
  String get sendCode => 'Enviar código';

  @override
  String get enterVerificationCode => 'Ingresa el código';

  @override
  String codeSentTo(String phone) {
    return 'Enviamos un código SMS a $phone';
  }

  @override
  String get verify => 'Verificar';

  @override
  String get resendCode => 'Reenviar código';

  @override
  String resendCodeIn(int seconds) {
    return 'Reenviar código en ${seconds}s';
  }

  @override
  String get changePhoneNumber => 'Cambiar número';

  @override
  String get phoneVerified => 'Teléfono verificado correctamente';

  @override
  String get invalidCode => 'Código incorrecto';

  @override
  String get chatWithDriver => 'Chat con conductor';

  @override
  String get typeMessage => 'Escribe un mensaje...';

  @override
  String get send => 'Enviar';

  @override
  String get noMessages => 'No hay mensajes aún';

  @override
  String get startConversation => 'Inicia la conversación';

  @override
  String get rateYourTrip => 'Califica tu viaje';

  @override
  String get howWasYourTrip => '¿Cómo estuvo tu viaje?';

  @override
  String get leaveComment => 'Deja un comentario (opcional)';

  @override
  String get commentPlaceholder => 'Cuéntanos sobre tu experiencia...';

  @override
  String get submitRating => 'Enviar calificación';

  @override
  String get skipRating => 'Omitir';

  @override
  String get thankYouForRating => 'Gracias por tu calificación';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get deleteAccountWarning =>
      'Esta acción es irreversible. Todos tus datos serán eliminados permanentemente.';

  @override
  String get confirmDeleteAccount =>
      '¿Estás seguro de que quieres eliminar tu cuenta?';

  @override
  String get typeDeleteToConfirm => 'Escribe ELIMINAR para confirmar';

  @override
  String get accountDeleted => 'Tu cuenta ha sido eliminada';

  @override
  String get delete => 'Eliminar';
}
