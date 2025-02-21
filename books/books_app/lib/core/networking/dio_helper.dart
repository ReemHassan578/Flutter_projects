import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class DioHelper {
  static Dio? dio;

  /// constructor as I don't want to allow creating an instance from dio
  DioHelper._();

  static Dio getDio() {
    Duration timeout = const Duration(seconds: 30);
    if (dio == null) {
      dio = Dio()
        ..options.connectTimeout = timeout
        ..options.receiveTimeout = timeout;
      addInterceptor();
      return dio!;
    }
    return dio!;
  }

  static void addInterceptor() {
    
    dio!.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      
      )
    );
  }
}