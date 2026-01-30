import 'package:dio/dio.dart';
import '../../core/constants/api_endpoints.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 3000),
        )) {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Dio get client => _dio;

  // Thêm các phương thức wrapper GET, POST, PUT, DELETE tại đây nếu cần
}
