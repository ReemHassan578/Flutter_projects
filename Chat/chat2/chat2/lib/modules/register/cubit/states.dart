abstract class RegisterStates {}

class InitialState extends RegisterStates {}

class TogglePasswordVisibilty extends RegisterStates {}

class LoadingRegisterState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class RegisterSucessState extends RegisterStates {}
