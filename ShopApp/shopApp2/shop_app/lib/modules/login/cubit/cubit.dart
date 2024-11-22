import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../shared/network/end_points.dart';
import 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) {
    return BlocProvider.of(context);
  }

  bool isPassword = true;

  void togglePassword() {
    isPassword = !isPassword;
    emit(TogglePasswordVisibilty());
  }

  LoginModel? loginData;

  void loginUser({required String email, required String password}) {
    emit(LoadingLoginState());

    DioHelper.postData(LOGIN, data: {'email': email, 'password': password})
        .then(
      (value) {
        loginData = LoginModel.fromJson(value.data);
        if (loginData!.status) {
          emit(LoginSucessState(loginData!.message));
        } else {
          emit(LoginErrorState(loginData!.message));
        }
      },
    ).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }
}
