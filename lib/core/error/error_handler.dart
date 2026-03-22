import 'package:dio/dio.dart';
import 'package:patient_project/core/error/app_exception.dart';

class ErrorHandler {
  static AppException handle(Object error) {
    if (error is DioException) return _handleDioException(error);
    if (error is AppException) return error;
    return const UnknownException();
  }

  static AppException _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException();
      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode);
      default:
        return const UnknownException();
    }
  }

  static AppException _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 401:
        return const UnauthorizedException();
      case 404:
        return const NotFoundException();
      case != null when statusCode >= 500:
        return const ServerException();
      default:
        return const UnknownException();
    }
  }
}
