import 'package:dio/dio.dart';
import '../network_exceptions.dart';

/// Интерсептор для преобразования ошибок Dio в доменные исключения.
/// 
/// Анализирует тип ошибки DioException и создаёт соответствующее
/// доменное исключение для использования в бизнес-логике.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _mapDioException(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: exception,
        message: exception.message,
      ),
    );
  }

  /// Преобразует DioException в доменное исключение.
  NetworkException _mapDioException(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException('Превышено время ожидания сервера');
        
      case DioExceptionType.badResponse:
        return _mapStatusCodeException(err.response);
        
      case DioExceptionType.cancel:
        return const CancelledException();
        
      case DioExceptionType.connectionError:
        return const NoConnectionException();
        
      case DioExceptionType.badCertificate:
        return const NetworkException('Ошибка сертификата безопасности');
        
      case DioExceptionType.unknown:
        if (err.message?.contains('SocketException') == true ||
            err.message?.contains('Connection refused') == true) {
          return const NoConnectionException();
        }
        return NetworkException(
          err.message ?? 'Неизвестная сетевая ошибка',
          err.response?.data,
        );
    }
  }

  /// Преобразует HTTP статус-код в соответствующее исключение.
  NetworkException _mapStatusCodeException(Response? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;
    
    switch (statusCode) {
      case 400:
        return BadRequestException('Некорректный запрос', data);
      case 401:
        return const UnauthorizedException();
      case 403:
        return const ForbiddenException('Ошибка доступа к сервису. Проверьте интернет-соединение.');
      case 404:
        return const NotFoundException();
      case 429:
        return const NetworkException('Слишком много запросов. Попробуйте позже.');
      case 500:
      case 501:
      case 502:
      case 503:
        return ServerException('Ошибка сервера', statusCode, data);
      default:
        return ServerException(
          'HTTP ошибка: $statusCode',
          statusCode,
          data,
        );
    }
  }
}
