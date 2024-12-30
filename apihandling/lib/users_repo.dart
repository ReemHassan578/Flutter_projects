import 'package:apiapp/api_result.dart';
import 'package:apiapp/network_exception.dart';
import 'package:apiapp/user_model.dart';
import 'package:apiapp/web_services.dart';

class UsersRepo {
  final ApiPackage webService;
  UsersRepo({required this.webService});

  Future<ApiResult<List<UserModel>>> getAllUsers() async {
    try {
      var responseData = await webService.get(
        allUsers,
      );
      List<UserModel> users = (responseData.data as List).map((element) {
        return UserModel.fromJson(element as Map<String, dynamic>);
      }).toList();

      return ApiResult.success(users);
    } catch (error) {
      return ApiResult.failure(NetworkException.getDioException(error));
    }
  }

  Future<ApiResult<UserModel>> getCetainUser(int userId) async {
    try {
      var responseData = await webService.get('$allUsers/$userId');

      return ApiResult.success(
          UserModel.fromJson(responseData.data as Map<String, dynamic>));
    } catch (error) {
      return ApiResult.failure(NetworkException.getDioException(error));
    }
  }

  Future<ApiResult<UserModel>> addNewUser(UserModel user) async {
    try {
      var responseData = await webService.post(allUsers, user.toJson(),
          '8d5f45687fb4fe3ecfd47c49eda42ae0e39430811472a2f64032aee096c7935e');
      return ApiResult.success(
          UserModel.fromJson(responseData.data as Map<String, dynamic>));
    } catch (error) {
      return ApiResult.failure(NetworkException.getDioException(error));
    }
  }

  Future<ApiResult> deleteUser(int userId) async {
    try {
      var response = await webService.delete('$allUsers/$userId',
          '8d5f45687fb4fe3ecfd47c49eda42ae0e39430811472a2f64032aee096c7935e');
      return ApiResult.success(response.data);
    } catch (error) {
      return ApiResult.failure(NetworkException.getDioException(error));
    }
  }
}

String allUsers = 'users';
