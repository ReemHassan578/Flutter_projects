import 'package:appointmentapp/core/networking/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_states.freezed.dart';

@freezed
class LoginStates<T> with _$LoginStates<T>{

const factory LoginStates.initial() = _initial;

const factory LoginStates.success(T data) =Success<T>;
const factory LoginStates.failure(ApiErrorModel error) =Failure;
const factory LoginStates.loading() =Loading;



}

