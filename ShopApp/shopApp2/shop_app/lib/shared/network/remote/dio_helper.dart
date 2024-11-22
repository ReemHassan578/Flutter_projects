import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  static Future<Response> getData(
    String url, {
    Map<String, dynamic>? headers,
  }) {
    dio.options.headers = headers;

    return dio.get(url);
  }

  static Future<Response> postData(String url,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data}) {
        
    dio.options.headers = headers;

    return dio.post(url, queryParameters: query, data: data);
  }
}
