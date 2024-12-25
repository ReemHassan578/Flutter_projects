abstract class LoginStates {}

class InitialState extends LoginStates {}

class TogglePasswordVisibilty extends LoginStates {}

class LoadingLoginState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class LoginSucessState extends LoginStates {}
