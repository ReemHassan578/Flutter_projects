import 'package:apiapp/cubit/users_cubit.dart';
import 'package:apiapp/users_repo.dart';
import 'package:apiapp/web_services.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerLazySingleton<UsersCubit>(() => UsersCubit(repo: getIt()));
  getIt.registerLazySingleton<UsersRepo>(() => UsersRepo(webService: getIt()));
  getIt.registerLazySingleton<ApiPackage>(() => DioHelper());
}
