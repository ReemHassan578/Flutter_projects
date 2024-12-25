import 'package:dio/dio.dart';

import '../../../core/constants/strings.dart';
import 'api_package.dart';

class DioHelper extends ApiPackage {
  final Dio dio;

  DioHelper()
      : dio = Dio(BaseOptions(
            baseUrl: baseUrl,
            receiveDataWhenStatusError: true,
            connectTimeout: const Duration(seconds: 60),
            receiveTimeout: const Duration(seconds: 60)));

  @override
  Future<List<dynamic>?> get(String path) async {
    try {
      Response response = await dio.get(path);

      return response.data;
    } catch (error) {
      return null;
    }
  }
}
