import 'package:appointmentapp/features/login/data/models/login_request_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:appointmentapp/features/login/data/repos/login_repo.dart';
import 'package:appointmentapp/features/login/domain/cubit/login_states.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/shared_preferences_helper.dart';
import '../../../../core/networking/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final LoginRepo _loginRepo;
  LoginCubit(
    this._loginRepo,
  ) : super(const LoginStates.initial());

   Future<void> saveUserToken(String token) async {
    isUserLogin = true;
   await  SharedPreferencesHelper.setSecuredString(
        SharedPreferencesKeys.userToken, token);
           await DioHelper.refreshHeadearWithToken();

  }

  emitLoginState() async {
    emit(const LoginStates.loading());
    var response = await _loginRepo.login(LoginRequestBody(
        email: emailController.text, password: passwordController.text));
    response.when(
      success: (loginResponse) async {
        await saveUserToken(loginResponse.data.token);
          emit(LoginStates.success(loginResponse));
      },
      failure: (error) {
        emit(LoginStates.failure(error));
      },
    );
  }
}
