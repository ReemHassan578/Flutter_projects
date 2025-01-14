import 'package:appointmentapp/core/networking/api_constants.dart';
import 'package:appointmentapp/features/login/data/models/login_request_body.dart';
import 'package:appointmentapp/features/login/data/models/login_response.dart';
import 'package:appointmentapp/features/signup/data/models/register_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/signup/data/models/register_request_body.dart';

part 'api_service.g.dart';

@RestApi(baseUrl:ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequestBody user);

 @POST(ApiConstants.register)
  Future<RegisterResponse> register(@Body() RegisterRequestBody user);
}

