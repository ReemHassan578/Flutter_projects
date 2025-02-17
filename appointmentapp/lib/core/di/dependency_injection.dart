import 'package:appointmentapp/core/networking/api_service.dart';
import 'package:appointmentapp/core/networking/dio_helper.dart';
import 'package:appointmentapp/features/home/data/apis/home_api_service.dart';
import 'package:appointmentapp/features/home/data/repos/home_repo.dart';
import 'package:appointmentapp/features/home/domain/cubit/home_cubit.dart';
import 'package:appointmentapp/features/login/data/repos/login_repo.dart';
import 'package:appointmentapp/features/login/domain/cubit/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/signup/data/repos/register_repo.dart';
import '../../features/signup/domain/cubit/register_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  final Dio dio=DioHelper.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio),);
 
 // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(apiService: getIt()),);
  getIt.registerFactory<LoginCubit>(() => LoginCubit( getIt()),);

//register
getIt.registerLazySingleton<RegisterRepo>(() => RegisterRepo(apiService: getIt()),);
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit( registerRepo: getIt()),);

//home
  getIt.registerLazySingleton<HomeApiService>(() => HomeApiService(dio),);
getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(homeApiService: getIt()),);


  

}
