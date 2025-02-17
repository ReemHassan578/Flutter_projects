import 'package:appointmentapp/core/networking/api_constants.dart';
import 'package:appointmentapp/features/home/data/apis/home_api_constatnts.dart';
import 'package:appointmentapp/features/home/data/models/all_specialization_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_service.g.dart';

@RestApi(baseUrl:ApiConstants.baseUrl)
abstract class HomeApiService {

  factory HomeApiService(Dio dio, {String baseUrl}) = _HomeApiService;

 @GET(HomeApiConstatnts.allSpecialization)
  Future<AllSpecializationResponse> getAllSpecialization();


}
