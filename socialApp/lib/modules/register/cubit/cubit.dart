import '../../../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/netwok/remote/firestore_helper.dart';
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

  UserCredential? userCredential;

  void registerUser({
    required String name,
    required String phone,
    required String email,
    required password,
  }) {
    emit(LoadingRegisterState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        userCredential = value;

        addUsertoFirestore(
          user: UserModel(
            name: name,
            uId: value.user!.uid,
            phone: phone,
            email: email,
          ),
        );
      },
    ).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void addUsertoFirestore({
    required UserModel user,
  }) {
    emit(LoadingRegisterState());
    FireStoreHelper.addUser(user).then(
      (value) {
        emit(RegisterSucessState());
      },
    ).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }
}
