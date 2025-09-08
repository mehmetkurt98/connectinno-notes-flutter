import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize all dependencies (Firebase, Hive, DI, etc.)
  await init();

  runApp(const App());
}
