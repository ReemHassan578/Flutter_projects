import 'package:appointmentapp/core/networking/api_error_model.dart';
import 'package:appointmentapp/features/home/data/repos/home_repo.dart';
import 'package:appointmentapp/features/home/domain/cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/all_specialization_response.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeRepo homeRepo;
  HomeCubit({required this.homeRepo}) : super(const HomeStates.initial());

  AllSpecializationResponse? allSpecializations;
  List<Doctors>? currentDoctors;

  void getAllSpecialization() async {
    emit(const HomeStates.specializationLoading());
    var response = await homeRepo.getAllSpecialization();
    response.whenOrNull(
      success: (data) {
        allSpecializations = data;
        chooseSpeciality(allSpecializations!.data.first.id);
        emit(HomeStates.specializationSuccess(data));
      },
      failure: (error) => emit(HomeStates.specializationFailure(error)),
    );
  }

  void chooseSpeciality(int id) {
    Data chosenDoctors = allSpecializations!.data.firstWhere(
      (e) => e.id == id,
    );
    currentDoctors = chosenDoctors.doctors;
    // error or empty doctors
    if (currentDoctors == null || currentDoctors!.isEmpty) {
      emit(HomeStates.chooseCategoryFailure(
          ApiErrorModel(message: 'no avaliable doctors in this category')));
    } else {
      emit(HomeStates.chooseCategorySuccess(currentDoctors!));
    }
  }
}
