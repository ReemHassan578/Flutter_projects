import 'package:dio/dio.dart';

class DioHelper extends ApiPackage {
  late Dio dio;

  DioHelper() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://gorest.co.in/public/v2/',
          headers: {'Content-Type': 'application/json'}),
    )
      ..options.connectTimeout = Duration(seconds: 20)
      ..options.receiveTimeout = Duration(seconds: 20);
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: false,
      responseHeader: false,
      request: true,
      requestBody: true,
    ));
  }

  @override
  Future<Response> get(String endpoint) async {
    return await dio.get(
      endpoint,
    );
  }

  @override
  Future<Response> post(
      String endpoint, Map<String, dynamic> data, String token) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await dio.post(endpoint, data: data);
  }

  @override
  Future<Response> delete(String endpoint, String token) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    return await dio.delete(
      endpoint,
    );
  }
}

abstract class ApiPackage {
  get(String endpoint);
  post(String endpoint, Map<String, dynamic> data, String token);
  delete(String endpoint, String token);
}
