import 'package:books_app/core/helpers/constants.dart';
import 'package:books_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:books_app/features/home/data/repos_imp/home_repo_imp.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/home/data/data_sources/home_local_data_source.dart';
import '../networking/dio_helper.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  final Dio dio = DioHelper.getDio();
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSource(dio),
  );
   getIt.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSource(openedBox:Hive.box(booksBox) ),
  );
  getIt.registerLazySingleton<HomeRepoImp>(() => HomeRepoImp(homeLocalDataSource: getIt(), homeRemoteDataSource: getIt()), );
}
