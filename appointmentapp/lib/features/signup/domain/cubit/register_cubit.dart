import 'package:appointmentapp/features/signup/data/repos/register_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/register_request_body.dart';
import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  final RegisterRepo registerRepo;
  
    final GlobalKey<FormState> formKey=GlobalKey<FormState>() ;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();




  RegisterCubit({required this.registerRepo})
      : super(const RegisterStates.initial());

  register() async {
    emit(const RegisterStates.loading());
    final result = await registerRepo.register(RegisterRequestBody(name: 'Reem', email: emailController.text, phone: phoneController.text, gender: '0', password: passwordController.text, passwordConfirmation: passwordController.text));
    result.when(
      success: (data) {
        emit(RegisterStates.success(data));
      },
      failure: (error) {
        emit(RegisterStates.failure(error));
      },
    );
  }
}
