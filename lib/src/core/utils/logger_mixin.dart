import 'package:logger/logger.dart';

/// Logger mixin'i - ihtiyacı olan tüm sınıflara eklenebilir
mixin LoggerMixin {
  late final Logger _logger;

  /// Logger instance'ını başlatır
  void initLogger() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2, // Stack trace'de kaç method gösterilecek
        errorMethodCount: 8, // Error durumunda kaç method gösterilecek
        lineLength: 120, // Log satırının maksimum uzunluğu
        colors: true, // Renkli loglar
        printEmojis: true, // Emoji kullanımı
        printTime: true, // Zaman damgası
      ),
    );
  }

  /// Debug seviyesinde log
  void logDebug(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Info seviyesinde log
  void logInfo(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Warning seviyesinde log
  void logWarning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Error seviyesinde log
  void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Fatal seviyesinde log
  void logFatal(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  /// Verbose seviyesinde log
  void logVerbose(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }

  /// Kısa yöntemler - sık kullanılan loglar için
  void log(String message) => logInfo(message);
  void logE(String message, [dynamic error, StackTrace? stackTrace]) =>
      logError(message, error, stackTrace);
  void logW(String message, [dynamic error, StackTrace? stackTrace]) =>
      logWarning(message, error, stackTrace);
  void logD(String message, [dynamic error, StackTrace? stackTrace]) =>
      logDebug(message, error, stackTrace);
}
