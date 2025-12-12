import 'package:dio/dio.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/error_interceptor.dart';

/// Конфигурация и фабрика Dio клиентов для сетевых запросов.
/// 
/// Предоставляет предварительно настроенные экземпляры Dio
/// для различных API с общими настройками и интерсепторами.
class DioClient {
  /// Таймаут соединения (в миллисекундах).
  static const int _connectTimeout = 30000;
  
  /// Таймаут получения данных (в миллисекундах).
  static const int _receiveTimeout = 30000;

  /// Создаёт базовый экземпляр Dio с общими настройками.
  static Dio createDio({
    required String baseUrl,
    Map<String, dynamic>? headers,
    bool enableLogging = true,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(milliseconds: _connectTimeout),
        receiveTimeout: const Duration(milliseconds: _receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          ...?headers,
        },
      ),
    );

    // Добавляем интерсепторы
    if (enableLogging) {
      dio.interceptors.add(const LoggingInterceptor(
        showHeaders: false,
        showData: true,
      ));
    }
    
    dio.interceptors.add(ErrorInterceptor());

    return dio;
  }

  /// Создаёт Dio клиент для Disease.sh API (COVID-19 статистика).
  static Dio createDiseaseApiClient() {
    return createDio(
      baseUrl: 'https://disease.sh/v3/covid-19',
    );
  }

  /// Создаёт Dio клиент для RxNorm API (NIH) - информация о лекарствах.
  static Dio createDrugApiClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://rxnav.nlm.nih.gov/REST',
        connectTimeout: const Duration(milliseconds: _connectTimeout),
        receiveTimeout: const Duration(milliseconds: _receiveTimeout),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(const LoggingInterceptor(
      showHeaders: false,
      showData: true,
    ));
    dio.interceptors.add(ErrorInterceptor());

    return dio;
  }

  /// Создаёт Dio клиент для OpenFDA API с browser-like настройками.
  /// Использует специальные заголовки для обхода WAF/CDN защиты.
  static Dio createFdaApiClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.fda.gov',
        connectTimeout: const Duration(milliseconds: _connectTimeout),
        receiveTimeout: const Duration(milliseconds: _receiveTimeout),
        // Browser-like headers для обхода WAF
        headers: {
          'Accept': 'application/json, text/plain, */*',
          'Accept-Language': 'en-US,en;q=0.9',
          'Accept-Encoding': 'gzip, deflate, br',
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
          'Origin': 'https://open.fda.gov',
          'Referer': 'https://open.fda.gov/',
          'Sec-Ch-Ua': '"Not_A Brand";v="8", "Chromium";v="120", "Google Chrome";v="120"',
          'Sec-Ch-Ua-Mobile': '?0',
          'Sec-Ch-Ua-Platform': '"Windows"',
          'Sec-Fetch-Dest': 'empty',
          'Sec-Fetch-Mode': 'cors',
          'Sec-Fetch-Site': 'same-site',
        },
      ),
    );

    dio.interceptors.add(const LoggingInterceptor(
      showHeaders: true,
      showData: true,
    ));
    // Не добавляем ErrorInterceptor чтобы видеть реальные ошибки

    return dio;
  }
}
