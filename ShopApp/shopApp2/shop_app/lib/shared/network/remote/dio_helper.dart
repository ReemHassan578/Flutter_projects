import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          receiveTimeout: Duration(minutes: 5)),
    );
  }

  static Future<Response> getData(String url, {Map<String, dynamic>? headers}) {
    headers = headers ??
        {
          'Content-Type': 'application/json',
          'lan': 'ar',
        };
    dio.options.headers = headers;

    return dio.get(url);
  }

  static Future<Response> postData(String url,
      {Map<String, dynamic> headers = const {
        'Content-Type': 'application/json',
        'lan': 'ar',
      },
      Map<String, dynamic>? query,
      required Map<String, dynamic> data}) {
    dio.options.headers = headers;

    return dio.post(url, queryParameters: query, data: data);
  }
}
