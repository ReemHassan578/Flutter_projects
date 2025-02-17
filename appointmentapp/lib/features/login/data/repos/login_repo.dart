import 'package:appointmentapp/core/networking/api_error_handler.dart';
import 'package:appointmentapp/core/networking/api_result.dart';
import 'package:appointmentapp/core/networking/api_service.dart';
import 'package:appointmentapp/features/login/data/models/login_request_body.dart';
import 'package:appointmentapp/features/login/data/models/login_response.dart';

class LoginRepo {
  final ApiService apiService;

  LoginRepo({required this.apiService});

  Future<ApiResult<LoginResponse>> login(LoginRequestBody loginRequestBody) async {
    try {
      var response = await apiService.login(loginRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
