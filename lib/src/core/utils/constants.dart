/// Application constants
class AppConstants {
  // API Endpoints
  static const String baseUrl = 'http://10.0.2.2:8000'; // Android emulator

  static const String notesEndpoint = '/api/notes';
  static const String authEndpoint = '/api/auth';

  // Hive Box Names
  static const String notesBoxName = 'notes';
  static const String pendingOpsBoxName = 'pending_ops';
  static const String userBoxName = 'user';

  // App Info
  static const String appName = 'Connectinno Notes';
  static const String appVersion = '1.0.0';

  // Network
  static const int connectionTimeout = 10;
  static const int receiveTimeout = 10;
  static const int sendTimeout = 10;

  // Sync
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);
}
