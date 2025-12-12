/// Базовый класс исключений сетевого слоя.
class NetworkException implements Exception {
  final String message;
  final dynamic data;

  const NetworkException(this.message, [this.data]);

  @override
  String toString() => 'NetworkException: $message';
}

/// Исключение при таймауте соединения.
class TimeoutException extends NetworkException {
  const TimeoutException([String message = 'Превышено время ожидания'])
      : super(message);
}

/// Исключение при некорректном запросе (400).
class BadRequestException extends NetworkException {
  const BadRequestException([String message = 'Некорректный запрос', dynamic data])
      : super(message, data);
}

/// Исключение при отсутствии авторизации (401).
class UnauthorizedException extends NetworkException {
  const UnauthorizedException([String message = 'Требуется авторизация'])
      : super(message);
}

/// Исключение при отсутствии доступа (403).
class ForbiddenException extends NetworkException {
  const ForbiddenException([String message = 'Доступ запрещён'])
      : super(message);
}

/// Исключение при отсутствии ресурса (404).
class NotFoundException extends NetworkException {
  const NotFoundException([String message = 'Ресурс не найден'])
      : super(message);
}

/// Исключение при ошибке сервера (5xx).
class ServerException extends NetworkException {
  final int? statusCode;

  const ServerException([
    String message = 'Ошибка сервера',
    this.statusCode,
    dynamic data,
  ]) : super(message, data);
}

/// Исключение при отсутствии сети.
class NoConnectionException extends NetworkException {
  const NoConnectionException([String message = 'Отсутствует подключение к сети'])
      : super(message);
}

/// Исключение при отмене запроса.
class CancelledException extends NetworkException {
  const CancelledException([String message = 'Запрос отменён'])
      : super(message);
}
