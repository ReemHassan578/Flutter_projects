class LoginModel {
  final bool status;
  final String message;
  final DataModel? data;

  LoginModel.fromJson(Map<String, dynamic> loginData)
      : status = loginData['status'],
        message = loginData['message'],
        data = (loginData['data'] == null)
            ? null
            : DataModel.fromJson(loginData['data']);
}

class DataModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final int points;
  final int credit;
  final String token;
  final String image;

  DataModel.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        email = data['email'],
        phone = data['phone'],
        points = data['points'],
        credit = data['credit'],
        token = data['token'],
        image = data['image'];
}
