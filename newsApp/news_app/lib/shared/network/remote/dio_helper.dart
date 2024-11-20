import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://newsapi.org/',
      connectTimeout: const Duration(minutes: 2),
      sendTimeout: const Duration(minutes: 2),
      receiveTimeout: const Duration(minutes: 2),
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<List> getData(String url, Map<String, dynamic> map) async {
    try {
      Response response = await dio.get(
        url,
        queryParameters: map,
      );

      return response.data['articles'];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
