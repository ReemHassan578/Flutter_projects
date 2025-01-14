
import 'package:json_annotation/json_annotation.dart';

 part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
final  String message;
final Data data;
final bool status;
final int code; 


  RegisterResponse({required this.message, required this.data, required this.status, required this.code});
   factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);

}

@JsonSerializable()
class Data {
  final String token;
  @JsonKey(name: 'username')
  final String userName;


  Data({required this.token, required this.userName});
   factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);


}

