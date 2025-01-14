// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appointmentapp/features/login/data/models/login_request_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:appointmentapp/features/login/data/repos/login_repo.dart';
import 'package:appointmentapp/features/login/domain/cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {

    final GlobalKey<FormState> formKey=GlobalKey<FormState>() ;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();




  final LoginRepo _loginRepo;
  LoginCubit(
    this._loginRepo,
  ) : super(const LoginStates.initial());


  emitLoginState() async {
    emit(const LoginStates.loading());
    var response = await _loginRepo.login(LoginRequestBody(email: emailController.text, password: passwordController.text));
    response.when(
      success: (loginResponse) {
        emit(LoginStates.success(loginResponse));
      },
      failure: (error) {
        emit(LoginStates.failure(error));
      },
    );
  }
}
