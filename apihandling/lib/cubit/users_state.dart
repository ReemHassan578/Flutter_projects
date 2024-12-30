part of 'users_cubit.dart';

abstract class UsersState {}

class UsersInitialState extends UsersState {}

class GetAllUsersSucessState extends UsersState {}

class ErrorState extends UsersState {
  final String error;

  ErrorState({required this.error});
}

class GetCertainUserSucessState extends UsersState {}

class AddUserSucessState extends UsersState {}

class DeleteUserSucessState extends UsersState {}
