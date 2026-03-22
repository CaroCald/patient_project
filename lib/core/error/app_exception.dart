abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'Error de conexión. Verifica tu internet.']);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Sesión expirada. Inicia sesión nuevamente.']);
}

class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Recurso no encontrado.']);
}

class ServerException extends AppException {
  const ServerException([super.message = 'Error del servidor. Intenta más tarde.']);
}

class UnknownException extends AppException {
  const UnknownException([super.message = 'Ocurrió un error inesperado.']);
}
