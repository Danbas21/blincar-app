// lib/core/errors/failures.dart

import 'package:equatable/equatable.dart';

/// Clase base abstracta para todos los errores/fallos en la aplicacion
///
/// Siguiendo el principio de Clean Architecture, todos los errores
/// se representan como objetos Failure que cruzan las capas.
///
/// Principio aplicado: Open/Closed - Abierto para extension (nuevos Failures),
/// cerrado para modificacion.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => '$runtimeType: $message';
}

// ============================================
// FAILURES DE INFRAESTRUCTURA
// ============================================

/// Fallo del servidor o API externa
///
/// Usado cuando hay errores HTTP, timeouts, o respuestas invalidas del backend.
///
/// Ejemplos:
/// - Error 500 del servidor
/// - Timeout de conexion
/// - Respuesta JSON malformada
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(super.message, {this.statusCode});

  @override
  List<Object> get props => [message, statusCode ?? 0];
}

/// Fallo de cache o almacenamiento local
///
/// Usado cuando no se puede leer/escribir en SharedPreferences, Hive, etc.
///
/// Ejemplos:
/// - No se pudo guardar el token
/// - Error al leer datos en cache
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Fallo de red/conectividad
///
/// Usado cuando no hay conexion a internet o la red esta inestable.
///
/// Ejemplos:
/// - Sin conexion WiFi/datos moviles
/// - Timeout de red
/// - DNS no resuelve
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Fallo por timeout
///
/// Usado cuando una operacion excede el tiempo limite permitido.
///
/// Ejemplos:
/// - Operacion de red que tarda demasiado
/// - Consulta a base de datos lenta
class TimeoutFailure extends Failure {
  final Duration? duration;

  const TimeoutFailure(super.message, {this.duration});

  @override
  List<Object> get props => [message, duration ?? Duration.zero];
}

// ============================================
// FAILURES DE NEGOCIO
// ============================================

/// Fallo de validacion de datos
///
/// Usado cuando los datos del usuario no cumplen las reglas de negocio.
///
/// Ejemplos:
/// - Email invalido
/// - Contrasena muy corta
/// - Campos requeridos vacios
/// - Formato de telefono incorrecto
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure(super.message, {this.fieldErrors});

  @override
  List<Object> get props => [message, fieldErrors ?? {}];
}

/// Fallo de recurso no encontrado
///
/// Usado cuando se busca un recurso que no existe.
///
/// Ejemplos:
/// - Usuario no encontrado
/// - Viaje no existe
/// - Producto no disponible
class NotFoundFailure extends Failure {
  final String? resourceType;
  final String? resourceId;

  const NotFoundFailure(
    super.message, {
    this.resourceType,
    this.resourceId,
  });

  @override
  List<Object> get props => [message, resourceType ?? '', resourceId ?? ''];
}

/// Fallo de conflicto
///
/// Usado cuando hay un conflicto de estado o datos duplicados.
///
/// Ejemplos:
/// - Email ya registrado
/// - Viaje ya en progreso
/// - Recurso ya existe
class ConflictFailure extends Failure {
  const ConflictFailure(super.message);
}

/// Fallo de operacion no permitida
///
/// Usado cuando el usuario intenta una accion no autorizada.
///
/// Ejemplos:
/// - Usuario sin permisos para esta accion
/// - Operacion no permitida en este estado
class ForbiddenFailure extends Failure {
  const ForbiddenFailure(super.message);
}

// ============================================
// FAILURES DE AUTENTICACION
// ============================================

/// Fallo de autenticacion
///
/// Usado cuando hay problemas con login, registro, o sesion del usuario.
///
/// Ejemplos:
/// - Credenciales incorrectas
/// - Usuario no encontrado
/// - Email ya registrado
/// - Token expirado
/// - Sesion invalida
class AuthenticationFailure extends Failure {
  final AuthErrorType? errorType;

  const AuthenticationFailure(super.message, {this.errorType});

  @override
  List<Object> get props => [message, errorType ?? AuthErrorType.unknown];
}

/// Tipos de errores de autenticacion
enum AuthErrorType {
  invalidCredentials,
  userNotFound,
  emailAlreadyInUse,
  weakPassword,
  tokenExpired,
  sessionInvalid,
  unknown,
}

// ============================================
// FAILURES DE DISPOSITIVO
// ============================================

/// Fallo de ubicacion/GPS
///
/// Usado cuando no se puede obtener la ubicacion del dispositivo.
///
/// Ejemplos:
/// - GPS desactivado
/// - Permisos de ubicacion denegados
/// - No se pudo obtener coordenadas
class LocationFailure extends Failure {
  const LocationFailure(super.message);
}

/// Fallo de permisos
///
/// Usado cuando el usuario no otorga permisos necesarios.
///
/// Ejemplos:
/// - Permiso de camara denegado
/// - Permiso de almacenamiento denegado
/// - Permiso de ubicacion denegado permanentemente
class PermissionFailure extends Failure {
  final String? permission;
  final bool isPermanentlyDenied;

  const PermissionFailure(
    super.message, {
    this.permission,
    this.isPermanentlyDenied = false,
  });

  @override
  List<Object> get props => [message, permission ?? '', isPermanentlyDenied];
}

// ============================================
// FAILURES DE SERVICIOS EXTERNOS
// ============================================

/// Fallo de Firebase
///
/// Usado para errores especificos de servicios de Firebase
/// que no encajan en otras categorias.
///
/// Ejemplos:
/// - Error al subir archivo a Storage
/// - Error en Realtime Database
/// - Error en Cloud Functions
class FirebaseFailure extends Failure {
  final String? code;

  const FirebaseFailure(super.message, {this.code});

  @override
  List<Object> get props => [message, code ?? ''];
}

/// Fallo de servicio de pago
///
/// Usado para errores en procesamiento de pagos.
///
/// Ejemplos:
/// - Tarjeta rechazada
/// - Fondos insuficientes
/// - Error de procesamiento
class PaymentFailure extends Failure {
  final String? paymentErrorCode;

  const PaymentFailure(super.message, {this.paymentErrorCode});

  @override
  List<Object> get props => [message, paymentErrorCode ?? ''];
}

/// Fallo inesperado
///
/// Usado para errores no manejados o excepciones inesperadas.
/// Siempre debe loguearse para investigacion.
class UnexpectedFailure extends Failure {
  final dynamic originalError;
  final StackTrace? stackTrace;

  const UnexpectedFailure(
    super.message, {
    this.originalError,
    this.stackTrace,
  });

  @override
  List<Object> get props => [message, originalError ?? ''];
}

// lib/core/errors/payment_exceptions.dart

/// Excepciones base para pagos
sealed class PaymentException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const PaymentException({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() =>
      'PaymentException: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Usuario cancelo el pago
final class PaymentCancelledException extends PaymentException {
  const PaymentCancelledException({
    super.message = 'Pago cancelado por el usuario',
    super.code = 'payment_cancelled',
  });
}

/// Error de validacion
final class PaymentValidationException extends PaymentException {
  const PaymentValidationException({
    required super.message,
    super.code = 'validation_error',
    super.originalError,
  });
}

/// Error del servidor
final class PaymentServerException extends PaymentException {
  const PaymentServerException({
    required super.message,
    super.code = 'server_error',
    super.originalError,
  });
}

/// Error de red
final class PaymentNetworkException extends PaymentException {
  const PaymentNetworkException({
    super.message = 'No hay conexion a internet',
    super.code = 'network_error',
  });
}

/// Pago rechazado
final class PaymentDeclinedException extends PaymentException {
  const PaymentDeclinedException({
    required super.message,
    super.code = 'card_declined',
    super.originalError,
  });
}

/// Error de tokenizacion
final class TokenizationException extends PaymentException {
  const TokenizationException({
    required super.message,
    super.code = 'tokenization_error',
    super.originalError,
  });
}
