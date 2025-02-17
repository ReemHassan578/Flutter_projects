// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final String message;
  final bool? status;
  final int? code;
  //can be empty list or map of <String,dynamic>
  @JsonKey(name: 'data')
  final dynamic errors;

  //final Map<String, List> errors;
  ApiErrorModel({
     this.status,
     this.errors,
   required  this.message,
     this.code,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  String getAllErrorMessages() {
    if (errors ==null || errors.isEmpty )
     {
      return message;
    }
     else {
      String temErrors = '';
      errors.forEach((key, value) {

        for (String element in value) {
          temErrors += element;
        }
        temErrors += '$key : ${value.join(", ")}';
        });
      return temErrors;
    }
  }
}
