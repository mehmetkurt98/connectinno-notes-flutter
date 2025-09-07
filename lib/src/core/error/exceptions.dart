/// Base class for all exceptions in the application
abstract class AppException implements Exception {
  final String message;
  final int? code;

  const AppException({required this.message, this.code});

  @override
  String toString() => 'AppException: $message';
}

/// Server-related exceptions
class ServerException extends AppException {
  const ServerException({required super.message, super.code});
}

/// Network-related exceptions
class NetworkException extends AppException {
  const NetworkException({required super.message, super.code});
}

/// Authentication-related exceptions
class AuthException extends AppException {
  const AuthException({required super.message, super.code});
}

/// Cache-related exceptions
class CacheException extends AppException {
  const CacheException({required super.message, super.code});
}

/// Validation-related exceptions
class ValidationException extends AppException {
  const ValidationException({required super.message, super.code});
}

/// Unknown exceptions
class UnknownException extends AppException {
  const UnknownException({required super.message, super.code});
}
