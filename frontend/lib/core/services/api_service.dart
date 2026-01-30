import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider để truy cập ApiService từ bất kỳ đâu (Global)
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  late final Dio _dio;

  // Địa chỉ Server Backend (Thay đổi khi có server thật)
  // Nếu dùng Android Emulator: 10.0.2.2
  // Nếu dùng iOS Simulator: 127.0.0.1
  static const String _baseUrl = 'https://api.example.com/v1';

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Thêm Interceptor để log request/response (Giúp debug dễ hơn)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Có thể thêm Token vào header ở đây
          // options.headers['Authorization'] = 'Bearer $token';
          print('🌐 REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('✅ RESPONSE[${response.statusCode}] => DATA: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print('❌ ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  // Getter để truy cập Dio instance nếu cần custom sâu hơn
  Dio get dio => _dio;

  // Ví dụ các phương thức gọi API cơ bản
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } catch (e) {
      rethrow;
    }
  }
}
