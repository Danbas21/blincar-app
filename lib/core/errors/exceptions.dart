import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  final String message;

  const AppException(this.message);

  @override
  List<Object> get props => [message];
}

class ServerException extends AppException {
  final int statusCode;

  const ServerException({
    required String message,
    required this.statusCode,
  }) : super(message);

  @override
  List<Object> get props => [message, statusCode];
}

class CacheException extends AppException {
  const CacheException(super.message);
}

class NetworkException extends AppException {
  const NetworkException(super.message);
}

class ValidationException extends AppException {
  const ValidationException(super.message);
}

class LocationException extends AppException {
  const LocationException(super.message);
}
