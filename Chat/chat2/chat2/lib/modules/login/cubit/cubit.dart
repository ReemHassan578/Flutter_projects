import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:shop_app/shared/network/remote/dio_helper.dart';

//import '../../../shared/network/end_points.dart';
//import '../../../shared/network/local/cache_helper.dart';
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

  //LoginModel? loginData;

  void loginUser({required String email, required String password}) {
    emit(LoadingLoginState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        emit(LoginSucessState());
      },
    ).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }
}
