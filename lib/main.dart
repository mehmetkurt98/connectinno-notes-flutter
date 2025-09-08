import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

import 'firebase_options.dart';
import 'src/app.dart';
import 'src/core/di/injection_container.dart';

// Global logger instance for main.dart
final _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0, // main.dart için stack trace gerekmez
    lineLength: 80,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    _logger.w('⚠️ .env dosyası bulunamadı, default değerler kullanılacak');
  }

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize dependencies
  await init();

  runApp(const App());
}
