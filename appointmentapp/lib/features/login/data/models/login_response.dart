import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String message;
  final Data data;
  final bool status;
  final int code;

  LoginResponse({required this.message, required this.data, required this.status, required this.code});
   factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

}

@JsonSerializable()
class Data {
  final String token;
  @JsonKey(name: 'username')
  final String userName;


  Data({required this.token, required this.userName});
   factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);


}

