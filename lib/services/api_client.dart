import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.66.134:8000/api/v1', // Ganti dengan URL Laravel Anda
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  ApiClient() {
  dio.interceptors.add(InterceptorsWrapper(
  onRequest: (options, handler) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    print('Request: ${options.method} ${options.uri}');
    print('Headers: ${options.headers}');
    print('Data: ${options.data}');
    return handler.next(options);
  },
  onResponse: (response, handler) {
    print('Response Status: ${response.statusCode}');
    print('Response Data: ${response.data}');
    return handler.next(response);
  },
  onError: (DioException e, handler) {
    print('Error: ${e.message}');
    print('Error Response: ${e.response?.data}');
    print('Error Stack Trace: ${e.stackTrace}');
    return handler.next(e);
  },
  ));
}
}