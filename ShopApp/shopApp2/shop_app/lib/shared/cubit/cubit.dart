import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) {
    return BlocProvider.of(context);
  }

  bool isDark = false;

  void changeThemeMode({bool? isDarkFromCache}) {
    if (isDarkFromCache != null) {
      isDark = isDarkFromCache;
    } else {
      isDark = !isDark;
    }
    emit(ChangeThemeMode());
  }
}
