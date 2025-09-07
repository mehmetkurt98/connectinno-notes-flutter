import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../utils/constants.dart';

/// Custom Dio client with Firebase Auth token interceptor
class DioClient {
  static const String baseUrl = 'http://10.0.2.2:8000'; // Android emulator

  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: AppConstants.connectionTimeout),
        receiveTimeout: Duration(seconds: AppConstants.receiveTimeout),
        sendTimeout: Duration(seconds: AppConstants.sendTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      _AuthTokenInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    ]);
  }

  Dio get dio => _dio;
}

/// Interceptor to add Firebase Auth token to requests
class _AuthTokenInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final token = await user.getIdToken();
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      // Token alınamadı, request devam eder
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Error handling logic can be added here
    handler.next(err);
  }
}
