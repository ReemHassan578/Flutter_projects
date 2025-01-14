import 'package:appointmentapp/core/networking/api_result.dart';
import 'package:appointmentapp/core/networking/api_service.dart';
import 'package:appointmentapp/features/signup/data/models/register_response.dart';

import '../models/register_request_body.dart';

class RegisterRepo {
  final ApiService apiService;
  const RegisterRepo({required this.apiService});

  Future<ApiResult<RegisterResponse>> register(RegisterRequestBody user) async {
try{    final response = await apiService.register(user);
return ApiResult.success(response);
} catch(error){
return ApiResult.failure(error.toString());

}   
  }
}
