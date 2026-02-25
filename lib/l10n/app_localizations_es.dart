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

  @override
  String get activityTitle => 'Mi Actividad';

  @override
  String get noTripsYet => 'Sin viajes aún';

  @override
  String get noTripsDescription =>
      'Cuando completes tu primer viaje, aparecerá aquí';

  @override
  String get tripStatusCompleted => 'Completado';

  @override
  String get tripStatusCancelled => 'Cancelado';

  @override
  String get tripStatusPending => 'Pendiente';

  @override
  String get tripStatusAssigned => 'Asignado';

  @override
  String get tripStatusInProgress => 'En progreso';

  @override
  String get tripStatusAccepted => 'Aceptado';

  @override
  String get tripStatusRequested => 'Solicitado';

  @override
  String get forgotPasswordTitle => 'RECUPERAR CONTRASEÑA';

  @override
  String get forgotPasswordEmailHint => 'Ingresa tu correo electrónico...';

  @override
  String get sendLink => 'Enviar Enlace';

  @override
  String get backToLogin => 'Volver a Iniciar Sesión';

  @override
  String get emailSentTitle => '¡CORREO ENVIADO!';

  @override
  String get emailSentMessage => 'Hemos enviado un enlace de recuperación a:';

  @override
  String get checkInboxMessage => 'Revisa tu bandeja de entrada...';

  @override
  String get resendEmailLink => '¿No recibiste el correo? Intentar de nuevo';

  @override
  String get loginHeroText => 'MOVILIDAD DE ALTO NIVEL\nCON SEGURIDAD TOTAL.';

  @override
  String get loginTitle => 'INICIA SESIÓN';

  @override
  String get loginEmailLabel => 'Correo Electrónico Corporativo o Personal*';

  @override
  String get loginPasswordLabel => 'Contraseña*';

  @override
  String get forgotPasswordLink => '¿Has olvidado tu contraseña?';

  @override
  String get loginButton => 'Iniciar Sesión';

  @override
  String get registerLink => '¿Eres nuevo en BlinCar? ¡Inscríbete!';

  @override
  String get orDivider => 'o';

  @override
  String get continueWithApple => 'Continuar con Apple';

  @override
  String get continueWithGoogle => 'Continuar con Google';

  @override
  String get continueWithFacebook => 'Continuar con Facebook';

  @override
  String get facebookComingSoon => 'Facebook Sign In próximamente';

  @override
  String get registerTitle => 'Crear cuenta';

  @override
  String get registerSubtitle => 'Completa la información para registrarte';

  @override
  String get accountTypeLabel => 'Tipo de cuenta';

  @override
  String get passengerType => 'Pasajero';

  @override
  String get driverType => 'Conductor';

  @override
  String get nameHint => 'Tu nombre';

  @override
  String get lastNameHint => 'Tus apellidos';

  @override
  String get emailHint => 'tu@email.com';

  @override
  String get termsRequiredError => 'Debes aceptar los términos y condiciones';

  @override
  String get privacyRequiredError => 'Debes aceptar la política de privacidad';

  @override
  String get ineRequiredError => 'Debes cargar ambos lados de tu INE';

  @override
  String get documentsUploaded => 'Documentos subidos correctamente';

  @override
  String get ineLabel => 'Identificación Oficial (INE)';

  @override
  String get ineDescription => 'Sube fotos claras de tu INE';

  @override
  String get ineFront => 'Anverso (Frente)';

  @override
  String get ineFrontDescription => 'Foto con tu nombre y fotografía';

  @override
  String get ineBack => 'Reverso (Atrás)';

  @override
  String get ineBackDescription => 'Foto con el código de barras';

  @override
  String get securityNotice => 'Tu información está protegida y encriptada';

  @override
  String get uploadingDocuments => 'Subiendo documentos...';

  @override
  String get createAccountButton => 'Crear Cuenta';

  @override
  String get helpTitle => 'Ayuda y Soporte';

  @override
  String get faqSearchHint => 'Buscar en preguntas frecuentes...';

  @override
  String get faqTitle => 'Preguntas Frecuentes';

  @override
  String get noSearchResults => 'No se encontraron resultados';

  @override
  String get contactSupport => 'Contactar soporte';

  @override
  String helloName(String name) {
    return 'Hola, $name';
  }

  @override
  String get transportServices => 'Servicios de Transporte';

  @override
  String get byRoute => 'Por Ruta';

  @override
  String get predefinedRoutes => 'Rutas predefinidas';

  @override
  String get byDay => 'Por Día';

  @override
  String get fullService => 'Servicio completo';

  @override
  String get customizeTrip => 'Personaliza tu Viaje';

  @override
  String get originDestinationManual => 'Ingresa origen y destino manualmente';

  @override
  String get quickTrip => 'Viaje Rápido';

  @override
  String get wherePickup => '¿Dónde te recogemos?';

  @override
  String get whereGoing => '¿A dónde vas?';

  @override
  String get serviceTypeLabel => 'Tipo de servicio';

  @override
  String get scheduleLater => 'Programar para más tarde';

  @override
  String get changeButton => 'Cambiar';

  @override
  String get panicActivateConfirm =>
      '¿Estás seguro de activar el botón de pánico? Se enviará una alerta inmediata.';

  @override
  String get activateButton => 'Activar';

  @override
  String get byDayServiceTitle => 'Servicio Por Día';

  @override
  String get comingSoon => 'Próximamente disponible';

  @override
  String get byDayDescription =>
      'El servicio por día te permitirá contratar un conductor por tiempo completo';

  @override
  String get hoursService => '8 horas de servicio';

  @override
  String get multipleDestinations => 'Múltiples destinos';

  @override
  String get dedicatedDriver => 'Conductor dedicado';

  @override
  String get understood => 'Entendido';

  @override
  String get selectOrigin => 'Seleccionar origen';

  @override
  String get selectDestination => 'Seleccionar destino';

  @override
  String get calculatingRoute => 'Calculando ruta...';

  @override
  String get totalToPay => 'Total a pagar';

  @override
  String get continuePayment => 'Continuar al pago';

  @override
  String todayAt(String time) {
    return 'Hoy a las $time';
  }

  @override
  String tomorrowAt(String time) {
    return 'Mañana a las $time';
  }

  @override
  String get minimumScheduling =>
      'El viaje debe agendarse con al menos 30 minutos de anticipación';

  @override
  String get activityTab => 'Actividad';

  @override
  String get profileTab => 'Perfil';

  @override
  String get passengerLabel => 'Pasajero';

  @override
  String get mexicoOnly => 'Solo se permiten destinos dentro de México';

  @override
  String get searching => 'Buscando...';

  @override
  String get loadingAddress => 'Cargando dirección...';

  @override
  String get originPoint => 'Punto de origen';

  @override
  String get destinationPoint => 'Punto de destino';

  @override
  String get tapMap => 'Toca el mapa para seleccionar';

  @override
  String get confirmOrigin => 'Confirmar origen';

  @override
  String get confirmDestination => 'Confirmar destino';

  @override
  String get whereFrom => '¿Desde dónde sales?';

  @override
  String get selectLocationTitle => 'Seleccionar ubicación';

  @override
  String get markAllRead => 'Marcar todas';

  @override
  String get noNotifications => 'No tienes notificaciones';

  @override
  String get justNow => 'Hace un momento';

  @override
  String get paymentHistoryTitle => 'Historial de Pagos';

  @override
  String get totalPaid => 'Total pagado';

  @override
  String get completedTransactions => 'transacciones completadas';

  @override
  String get allFilter => 'Todos';

  @override
  String get refundsFilter => 'Reembolsos';

  @override
  String get pendingFilter => 'Pendientes';

  @override
  String get noTransactions => 'No hay transacciones';

  @override
  String get errorLoadingHistory => 'Error al cargar historial';

  @override
  String get statusFailed => 'Fallido';

  @override
  String get statusRefunded => 'Reembolsado';

  @override
  String get refreshButton => 'Actualizar';

  @override
  String get personalDocs => 'Personal';

  @override
  String get licenseDocs => 'Licencia';

  @override
  String get vehicleDocs => 'Vehículo';

  @override
  String get insuranceDocs => 'Seguros';

  @override
  String get docApproved => 'Aprobado';

  @override
  String get docRejected => 'Rechazado';

  @override
  String get docExpired => 'Vencido';

  @override
  String get docMissing => 'Faltante';

  @override
  String get docPending => 'Pendiente';

  @override
  String get reupload => 'Resubir';

  @override
  String get viewDocument => 'Ver Documento';

  @override
  String get uploadNewDocument => 'Subir Nuevo Documento';

  @override
  String get chooseUploadMethod =>
      'Selecciona cómo quieres subir tu documento:';

  @override
  String get selectFromGallery => 'Seleccionar de Galería';

  @override
  String get personalInformation => 'Información Personal';

  @override
  String get changeProfilePhoto => 'Cambiar foto de perfil';

  @override
  String get takePhotoOption => 'Tomar foto';

  @override
  String get chooseGallery => 'Elegir de galería';

  @override
  String get fullNameHint => 'Tu nombre completo';

  @override
  String get phone10Digits => '10 dígitos';

  @override
  String get changeEmailSection => 'Cambiar correo electrónico';

  @override
  String get emailVerificationNotice =>
      'Se enviará un correo de verificación...';

  @override
  String get newEmail => 'Nuevo correo electrónico';

  @override
  String get updateEmailButton => 'Actualizar correo';

  @override
  String get changePasswordSection => 'Cambiar contraseña';

  @override
  String get min8Chars => 'Mínimo 8 caracteres';

  @override
  String get repeatNewPassword => 'Repite la nueva contraseña';

  @override
  String get passwordsMismatch => 'Las contraseñas no coinciden';

  @override
  String get myReservations => 'Mis Reservaciones';

  @override
  String get activeFilter => 'Activas';

  @override
  String get pastFilter => 'Pasadas';

  @override
  String get cancelledFilter => 'Canceladas';

  @override
  String get noReservations => 'No tienes reservaciones';

  @override
  String get reservationDetails => 'Detalles de Reservación';

  @override
  String get reservationId => 'ID:';

  @override
  String get reservationConfirmed => 'Confirmada';

  @override
  String get reservationCompleted => 'Completada';

  @override
  String get reservationCancelled => 'Cancelada';

  @override
  String get modifyButton => 'Modificar';

  @override
  String get cancelReservation => 'Cancelar';

  @override
  String get notificationTypes => 'Tipos de notificaciones';

  @override
  String get notifTrips => 'Viajes';

  @override
  String get notifPayments => 'Pagos';

  @override
  String get notifSecurity => 'Seguridad';

  @override
  String get notifPromotions => 'Promociones';

  @override
  String get soundVibration => 'Sonido y vibración';

  @override
  String get soundLabel => 'Sonido';

  @override
  String get soundDescription => 'Reproducir sonido con las notificaciones';

  @override
  String get vibrationLabel => 'Vibración';

  @override
  String get vibrationDescription => 'Vibrar con las notificaciones';

  @override
  String get doNotDisturb => 'No molestar';

  @override
  String get quietHours => 'Horario de silencio';

  @override
  String get quietHoursDescription =>
      'Silenciar notificaciones durante un horario';

  @override
  String get startTime => 'Inicio';

  @override
  String get endTime => 'Fin';

  @override
  String get securityAlertsAlways =>
      'Las alertas de seguridad siempre se mostrarán';

  @override
  String get notificationsEnabled => 'Notificaciones activas';

  @override
  String get notificationsDisabled => 'Notificaciones desactivadas';

  @override
  String get enableSystemNotifications =>
      'Por favor habilita notificaciones en configuración del sistema';

  @override
  String get importantLabel => 'Importante';

  @override
  String get enableButton => 'Activar';

  @override
  String get confirmPaymentTitle => 'Confirmar pago';

  @override
  String get selectPaymentMethod => 'Selecciona un método de pago';

  @override
  String get paymentInProgress => 'Ya hay un pago en proceso';

  @override
  String get additionalAuthRequired => 'Se requiere autenticación adicional';

  @override
  String get paymentRejected => 'Pago rechazado:';

  @override
  String get paymentProcessingError => 'Error procesando el pago';

  @override
  String get paymentConfirmedStatus => 'Pago confirmado';

  @override
  String get paymentProcessed => 'Se ha procesado el pago de';

  @override
  String get lookingForDriver => 'Buscar conductor';

  @override
  String get addNewCard => 'Agregar nueva tarjeta';

  @override
  String get estimatedTime => 'Tiempo estimado';

  @override
  String get paymentSecurityNotice =>
      'Pago seguro. Tu información está protegida con encriptación de nivel bancario.';

  @override
  String get originLabel => 'Origen';

  @override
  String get destinationLabel => 'Destino';

  @override
  String get serviceLabel => 'Servicio';

  @override
  String get allTrips => 'Todos';

  @override
  String get completedTrips => 'Completados';

  @override
  String get cancelledTrips => 'Cancelados';

  @override
  String get noTripsDisplay => 'No hay viajes para mostrar';

  @override
  String get selectRoute => 'Selecciona tu ruta';

  @override
  String get noRoutes => 'No hay rutas disponibles';

  @override
  String get reloadRoutes => 'Recargar rutas';

  @override
  String get changeRoute => 'Cambiar ruta';

  @override
  String get distanceLabel => 'Distancia';

  @override
  String get servicePtp => 'Punto a Punto';

  @override
  String get serviceArmedEscort => 'Con Escolta Armado';

  @override
  String get serviceUnarmedEscort => 'Con Escolta Desarmado';

  @override
  String get serviceArmoredEscort => 'Auto Blindado + Escolta';

  @override
  String get requestTripButton => 'Solicitar viaje';

  @override
  String get includesTolls => '(incluye casetas)';

  @override
  String get tripInProgressTitle => 'Viaje en Curso';

  @override
  String get tripCompletedTitle => 'Viaje Completado';

  @override
  String get tripSuccessMessage => '¡Tu viaje ha finalizado con éxito!';

  @override
  String get totalLabel => 'Total';

  @override
  String get durationLabel => 'Duración';

  @override
  String get skipButton => 'Omitir';

  @override
  String get rateTripButton => 'Calificar viaje';

  @override
  String get exitTripTitle => '¿Salir del viaje?';

  @override
  String get exitTripMessage =>
      'Tu viaje está en curso. ¿Estás seguro de que quieres salir? Podrás regresar desde la página principal.';

  @override
  String get exitButton => 'Salir';

  @override
  String get phoneNotAvailable => 'Número de teléfono no disponible';

  @override
  String get cannotMakeCall => 'No se puede realizar la llamada';

  @override
  String get errorLoadingTrip => 'Error al cargar el viaje';

  @override
  String get onlyDriverFinish => 'Solo el conductor puede finalizar el viaje';

  @override
  String get waitingFinish => 'Esperando finalización';

  @override
  String get panicButtonLabel => 'PÁNICO';

  @override
  String get vehicleTypeLabel => 'Suburban Ejecutiva';

  @override
  String get waitingTitle => 'Esperando asignación';

  @override
  String get driverAssignedTitle => '¡Conductor asignado!';

  @override
  String get driverOnWay => 'Tu conductor está en camino';

  @override
  String get vehicleLabel => 'Vehículo';

  @override
  String get viewTrip => 'Ver viaje';

  @override
  String get tripCancelledTitle => 'Viaje cancelado';

  @override
  String get tripCancelledMessage => 'Tu viaje ha sido cancelado.';

  @override
  String get tripDetails => 'Detalles del viaje';

  @override
  String get routeLabel => 'Ruta';

  @override
  String get priceLabel => 'Precio';

  @override
  String get requestedLabel => 'Solicitado';

  @override
  String get cancelTripButton => 'Cancelar viaje';

  @override
  String get stayButton => 'Quedarme';

  @override
  String get exitAssignmentMessage =>
      'Tu viaje sigue en proceso de asignación. ¿Deseas salir?';

  @override
  String get cancelTripConfirm =>
      '¿Estás seguro de que deseas cancelar este viaje?';

  @override
  String get yesCancel => 'Sí, cancelar';

  @override
  String get driverLabel => 'Conductor';

  @override
  String get useDeviceCamera => 'Usar la cámara del dispositivo';

  @override
  String get acceptTermsPrefix => 'Acepto los ';

  @override
  String get termsLink => 'términos y condiciones';

  @override
  String get acceptPrivacyPrefix => 'Acepto la ';

  @override
  String get privacyLink => 'política de privacidad';

  @override
  String errorUploadingDocs(String error) {
    return 'Error subiendo documentos: $error';
  }

  @override
  String get paymentConfirmed => 'Pago confirmado';

  @override
  String paymentProcessedMessage(String amount) {
    return 'Se ha procesado el pago de $amount';
  }

  @override
  String get confirmPayment => 'Confirmar pago';

  @override
  String get noSavedCards => 'Sin tarjetas guardadas';

  @override
  String get addCardToContinue => 'Agrega una tarjeta para continuar';

  @override
  String get processingPayment => 'Procesando pago...';

  @override
  String get retryingPayment => 'Reintentando...';

  @override
  String get confirmingPayment => 'Confirmando pago...';

  @override
  String get paymentCompleted => 'Pago completado';

  @override
  String get retryPayment => 'Reintentar pago';

  @override
  String payAmount(String amount) {
    return 'Pagar \$$amount';
  }

  @override
  String get securePaymentNote =>
      'Pago seguro. Tu información está protegida con encriptación de nivel bancario.';

  @override
  String cardExpires(String date) {
    return 'Vence $date';
  }

  @override
  String get defaultCard => 'Principal';

  @override
  String minutesAgo(int minutes) {
    return 'Hace $minutes min';
  }

  @override
  String get exitTitle => 'Salir';

  @override
  String get cancelTripConfirmMessage =>
      '¿Estás seguro de que deseas cancelar este viaje?';

  @override
  String get noButton => 'No';

  @override
  String get yesCancelButton => 'Sí, cancelar';

  @override
  String get tripCompletedMessage => '¡Tu viaje ha finalizado con éxito!';

  @override
  String get onlyDriverCanEnd => 'Solo el conductor puede finalizar el viaje';

  @override
  String get waitingCompletion => 'Esperando finalización';

  @override
  String get statusInProgress => 'En Curso';

  @override
  String get statusPending => 'Pendiente';

  @override
  String get statusAssigned => 'Asignado';

  @override
  String availableRoutes(int count) {
    return 'Rutas Disponibles ($count)';
  }

  @override
  String get selectYourRoute => 'Selecciona tu ruta';

  @override
  String get noRoutesAvailable => 'No hay rutas disponibles';

  @override
  String get checkConsoleDetails => 'Revisa la consola para más detalles';

  @override
  String get minutes => 'minutos';

  @override
  String get serviceType => 'Tipo de servicio';

  @override
  String get mustLogin => 'Debes iniciar sesión';

  @override
  String get byRouteTitle => 'Por Ruta';

  @override
  String get byRouteSubtitle => 'Rutas predefinidas';

  @override
  String get byDayTitle => 'Por Día';

  @override
  String get byDaySubtitle => 'Servicio completo';

  @override
  String get customTripTitle => 'Personaliza tu Viaje';

  @override
  String get customTripSubtitle => 'Ingresa origen y destino manualmente';

  @override
  String get navHome => 'Inicio';

  @override
  String get navRoutes => 'Rutas';

  @override
  String get navActivity => 'Actividad';

  @override
  String get navProfile => 'Perfil';

  @override
  String get scheduleForLater => 'Programar para más tarde';

  @override
  String get selectOriginDestination => 'Selecciona origen y destino';

  @override
  String get errorPrefix => 'Error';

  @override
  String get scheduleMinTime =>
      'El viaje debe agendarse con al menos 30 minutos de anticipación';

  @override
  String get panicDialogTitle => 'Botón de Pánico';

  @override
  String get panicDialogMessage =>
      '¿Estás seguro de activar el botón de pánico? Se enviará una alerta inmediata.';

  @override
  String get continueToPay => 'Continuar al pago';

  @override
  String get passengerRole => 'Pasajero';

  @override
  String get onlyMexicoDestinations =>
      'Solo se permiten destinos dentro de México';

  @override
  String get tapMapToSelect => 'Toca el mapa para seleccionar';

  @override
  String get personalDocsTitle => 'Documentos Personales';

  @override
  String get personalDocsDescription =>
      'Identificación oficial vigente requerida para el servicio';

  @override
  String get notifTripsDescription =>
      'Actualizaciones sobre el estado de tus viajes';

  @override
  String get notifPaymentsDescription => 'Confirmaciones y recibos de pago';

  @override
  String get notifSecurityDescription =>
      'Alertas importantes de seguridad y cuenta';

  @override
  String get notifPromotionsDescription => 'Ofertas y descuentos especiales';

  @override
  String get notificationsEnabledDesc => 'Recibirás notificaciones de Blincar';

  @override
  String get changeLabel => 'Cambiar';

  @override
  String get scheduleMinimumTime =>
      'El viaje debe agendarse con al menos 30 minutos de anticipación';

  @override
  String get activate => 'Activar';

  @override
  String get loginRequired => 'Debes iniciar sesión';

  @override
  String get serviceTypePtoP => 'Punto a Punto';

  @override
  String get serviceTypeArmedEscort => 'Con Escolta Armado';

  @override
  String get serviceTypeUnarmedEscort => 'Con Escolta Desarmado';

  @override
  String get serviceTypeArmored => 'Auto Blindado';

  @override
  String get serviceTypeArmoredEscort => 'Auto Blindado + Escolta';

  @override
  String get byDayComingSoon =>
      'El servicio por día te permitirá contratar un conductor y vehículo durante un día completo para múltiples traslados.';

  @override
  String get tripsCompleted => 'Viajes completados';

  @override
  String get totalSpent => 'Total gastado';

  @override
  String get registerLinkPrefix => '¿No tienes cuenta? ';

  @override
  String get registerLinkAction => 'Regístrate';

  @override
  String get supportDescription =>
      'Nuestro equipo de soporte está disponible las 24 horas para ayudarte';
}
