import 'dart:developer' as dev;
import 'package:dio/dio.dart';

/// Интерсептор для логирования сетевых запросов и ответов.
/// 
/// Записывает подробную информацию о всех сетевых операциях
/// для отладки и мониторинга.
class LoggingInterceptor extends Interceptor {
  final bool showHeaders;
  final bool showData;

  const LoggingInterceptor({
    this.showHeaders = false,
    this.showData = true,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final buffer = StringBuffer();
    buffer.writeln('🌐 ══════════════════════════════════════');
    buffer.writeln('🌐 REQUEST: ${options.method} ${options.uri}');
    
    if (showHeaders && options.headers.isNotEmpty) {
      buffer.writeln('🌐 Headers: ${options.headers}');
    }
    
    if (showData && options.data != null) {
      buffer.writeln('🌐 Body: ${options.data}');
    }
    
    if (options.queryParameters.isNotEmpty) {
      buffer.writeln('🌐 Query: ${options.queryParameters}');
    }
    
    buffer.writeln('🌐 ══════════════════════════════════════');
    dev.log(buffer.toString(), name: 'Network');
    
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final buffer = StringBuffer();
    buffer.writeln('✅ ══════════════════════════════════════');
    buffer.writeln('✅ RESPONSE [${response.statusCode}]: ${response.requestOptions.uri}');
    
    if (showHeaders && response.headers.map.isNotEmpty) {
      buffer.writeln('✅ Headers: ${response.headers.map}');
    }
    
    if (showData && response.data != null) {
      final dataStr = response.data.toString();
      if (dataStr.length > 500) {
        buffer.writeln('✅ Data: ${dataStr.substring(0, 500)}...');
      } else {
        buffer.writeln('✅ Data: $dataStr');
      }
    }
    
    buffer.writeln('✅ ══════════════════════════════════════');
    dev.log(buffer.toString(), name: 'Network');
    
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final buffer = StringBuffer();
    buffer.writeln('❌ ══════════════════════════════════════');
    buffer.writeln('❌ ERROR: ${err.type}');
    buffer.writeln('❌ URL: ${err.requestOptions.uri}');
    buffer.writeln('❌ Message: ${err.message}');
    
    if (err.response != null) {
      buffer.writeln('❌ Status: ${err.response?.statusCode}');
      if (showData && err.response?.data != null) {
        buffer.writeln('❌ Response: ${err.response?.data}');
      }
    }
    
    buffer.writeln('❌ ══════════════════════════════════════');
    dev.log(buffer.toString(), name: 'Network');
    
    handler.next(err);
  }
}
