import 'package:dio/dio.dart';

import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.badResponse:
          return _handleError(error.response?.data);
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message:'connection timeout');

        case DioExceptionType.connectionError:
          return ApiErrorModel(message:'connection error');

        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(message:'receive timeout');

        case DioExceptionType.unknown:
          return ApiErrorModel(message:'unknown error');

        case DioExceptionType.cancel:
          return ApiErrorModel(message:'cancelled');

        case DioExceptionType.sendTimeout:
          return ApiErrorModel(message:'send timeout');

        default:
          return ApiErrorModel(message:'Something went wrong');
      }
    } else {
      return ApiErrorModel(message:'unknown error ${error.toString()}');
    }
  }
}

ApiErrorModel _handleError(dynamic responseErrorData) {
  return ApiErrorModel(
    errorDetails: ErrorDetails(
        code: responseErrorData['code'],
        message: responseErrorData['message'],
        errors: responseErrorData['errors'],
        status: responseErrorData['status'],
        details: responseErrorData['details']),
  );
}
