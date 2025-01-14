import 'package:appointmentapp/core/networking/api_service.dart';
import 'package:appointmentapp/core/networking/dio_factory.dart';
import 'package:appointmentapp/features/login/data/repos/login_repo.dart';
import 'package:appointmentapp/features/login/domain/cubit/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/signup/data/repos/register_repo.dart';
import '../../features/signup/domain/cubit/register_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  final Dio dio=DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio),);
 
 // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(apiService: getIt()),);
  getIt.registerFactory<LoginCubit>(() => LoginCubit( getIt()),);

//register
getIt.registerLazySingleton<RegisterRepo>(() => RegisterRepo(apiService: getIt()),);
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit( registerRepo: getIt()),);

}
