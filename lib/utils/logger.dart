import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime
    )
  );

  static void t(String message) => _logger.t(message); //Trace: 詳細な動き
  static void d(String message) => _logger.d(message); //Debug: デバッグ情報
  static void i(String message) => _logger.i(message); //Info: 重要な進行状況
  static void w(String message) => _logger.w(message); //warning: 警告
  static void e(String message, [dynamic error, StackTrace? stackTrace]) => _logger.e(message, error: error, stackTrace: stackTrace); //
}