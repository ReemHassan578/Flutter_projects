import 'package:appointmentapp/core/networking/api_error_handler.dart';
import 'package:appointmentapp/core/networking/api_error_model.dart';
import 'package:appointmentapp/core/networking/api_result.dart';
import 'package:appointmentapp/features/home/data/apis/home_api_service.dart';

import '../models/all_specialization_response.dart';

class HomeRepo {
  HomeApiService homeApiService;
  HomeRepo({required this.homeApiService});

  Future<ApiResult<AllSpecializationResponse>> getAllSpecialization() async {
    try{
   AllSpecializationResponse response= await  homeApiService.getAllSpecialization()   ;
   return ApiResult.success(response);
    }
    catch(error){
    
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
