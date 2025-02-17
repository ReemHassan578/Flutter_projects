
import 'package:appointmentapp/core/networking/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'register_states.freezed.dart';


@freezed
class RegisterStates<T> with _$RegisterStates<T> {
  const factory RegisterStates.initial() = _Initial;
  const factory RegisterStates.success(T data) = Success<T>;
  const factory RegisterStates.failure(ApiErrorModel error) = Failure;
  const factory RegisterStates.loading() = Loading;

}
