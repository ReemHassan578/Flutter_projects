import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);
 
  }

