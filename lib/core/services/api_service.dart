import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../errors/exceptions.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: token != null
              ? ApiConstants.authHeaders(token)
              : ApiConstants.headers,
        ),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? data,
    String? token,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: token != null
              ? ApiConstants.authHeaders(token)
              : ApiConstants.headers,
        ),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? data,
    String? token,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        options: Options(
          headers: token != null
              ? ApiConstants.authHeaders(token)
              : ApiConstants.headers,
        ),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    String? token,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        options: Options(
          headers: token != null
              ? ApiConstants.authHeaders(token)
              : ApiConstants.headers,
        ),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data;
    } else {
      throw ServerException(
        message: 'Server returned ${response.statusCode}',
        statusCode: response.statusCode!,
      );
    }
  }

  ServerException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ServerException(
          message: 'Tiempo de conexión agotado',
          statusCode: 408,
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 500;
        final message =
            error.response?.data?['message'] ?? 'Error del servidor';
        return ServerException(
          message: message,
          statusCode: statusCode,
        );
      case DioExceptionType.cancel:
        return const ServerException(
          message: 'Solicitud cancelada',
          statusCode: 0,
        );
      default:
        return const ServerException(
          message: 'Error de conexión',
          statusCode: 500,
        );
    }
  }
}
