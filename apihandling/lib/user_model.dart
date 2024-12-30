import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  // @JsonKey(name: 'idd')
  final int? id;
  final String name;
  final String email;
  final String gender;
  final String status;

  UserModel(
      {this.id,
      required this.name,
      required this.email,
      required this.gender,
      required this.status});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
