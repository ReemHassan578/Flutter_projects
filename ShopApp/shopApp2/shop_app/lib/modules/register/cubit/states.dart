abstract class RegisterStates {}

class InitialState extends RegisterStates {}

class TogglePasswordVisibilty extends RegisterStates {}

class LoadingLoginState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class RegisterSucessState extends RegisterStates {
  final String msg;
  RegisterSucessState(this.msg);
}
