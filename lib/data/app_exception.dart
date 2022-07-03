class AppException implements Exception {
  final String? prefix;
  final String? message;

  AppException(
    this.prefix,
    this.message,
  );

  @override
  String toString() {
    return '$prefix$message';
  }
}

class FetchDataException extends AppException {
  FetchDataException(message) : super(message, "Error During Communication\n");
}

class BadRequestException extends AppException {
  BadRequestException(message) : super(message, "Bad Request\n");
}

class UnauthorizedException extends AppException {
  UnauthorizedException(message) : super(message, "Unauthorized Request\n");
}

class InvalidInputException extends AppException {
  InvalidInputException(message) : super(message, "Invalid Input Request\n");
}

class UnknownException extends AppException {
  UnknownException(message) : super(message, "Unknown Exception\n");
}
