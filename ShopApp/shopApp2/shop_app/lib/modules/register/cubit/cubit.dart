import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialState());

  static RegisterCubit get(context) {
    return BlocProvider.of(context);
  }

  bool isPassword = true;

  void togglePassword() {
    isPassword = !isPassword;
    emit(TogglePasswordVisibilty());
  }

  RegisterModel? registerData;

  void registerUser(
      {required String email,
      required String password,
      required String phone,
      required String name}) {
    emit(LoadingLoginState());

    DioHelper.postData(REGISTER, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    }, headers: {
      'Content-Type': 'application/json',
      'lang': 'ar',
    }).then(
      (value) {
        registerData = RegisterModel.fromJson(value.data);
        if (registerData!.status) {
          CacheHelper.saveData(key: 'token', value: registerData!.data!.token)
              .then(
            (value) {
              if (value) {
                emit(RegisterSucessState(registerData!.message));
                token = registerData!.data!.token;
              } else {
                emit(RegisterErrorState('Error in prefs'));
              }
            },
          );
          emit(RegisterSucessState(registerData!.message));
        } else {
          emit(RegisterErrorState(registerData!.message));
        }
      },
    ).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }
}
