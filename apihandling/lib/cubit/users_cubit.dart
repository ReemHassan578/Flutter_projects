import 'package:apiapp/user_model.dart';
import 'package:apiapp/users_repo.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network_exception.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersRepo repo;
  UsersCubit({required this.repo}) : super(UsersInitialState());

  static UsersCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  List<UserModel>? users;
  getAllUsers() {
    repo.getAllUsers().then((value) {
      value.when(success: (data) {
        users = data;
        emit(GetAllUsersSucessState());
      }, failure: (exception) {
        emit(ErrorState(error: NetworkException.getErrorMessage(exception)));
      });
    });
  }

  UserModel? certainUser;
  getCertainUser(int userId) {
    repo.getCetainUser(userId).then(
      (value) {
        value.when(
          success: (data) {
            certainUser = data;
            emit(GetCertainUserSucessState());
          },
          failure: (exception) {
            emit(
                ErrorState(error: NetworkException.getErrorMessage(exception)));
          },
        );
      },
    );
  }

  UserModel? newUser;
  addUser(UserModel user) {
    repo.addNewUser(user).then(
      (value) {
        value.when(
          success: (data) {
            newUser = data;
            emit(AddUserSucessState());
          },
          failure: (exception) {
            emit(
                ErrorState(error: NetworkException.getErrorMessage(exception)));
          },
        );
      },
    );
  }

  Future<void> deleteUser(int id) async {
    repo.deleteUser(id).then((response) {
      response.when(
        success: (data) {
          emit(DeleteUserSucessState());
        },
        failure: (exception) {
          emit(ErrorState(error: NetworkException.getErrorMessage(exception)));
        },
      );
    });
  }
}
