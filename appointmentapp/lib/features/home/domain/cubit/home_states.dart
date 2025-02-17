import 'package:appointmentapp/core/networking/api_error_model.dart';
import 'package:appointmentapp/features/home/data/models/all_specialization_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_states.freezed.dart';

@freezed
class HomeStates<T> with _$HomeStates<T> {
  const factory HomeStates.initial() = _Initial;

// all specialization
  const factory HomeStates.specializationSuccess(
      AllSpecializationResponse data) = SpecializationSuccess;
  const factory HomeStates.specializationFailure(ApiErrorModel error) =
      SpecializationFailure;
  const factory HomeStates.specializationLoading() = SpecializationLoading;

// for choose category
  const factory HomeStates.chooseCategorySuccess(List<Doctors> doctors) =
      ChooseCategorySuccess;
  const factory HomeStates.chooseCategoryFailure(ApiErrorModel error) =
      ChooseCategoryFailure;
}
