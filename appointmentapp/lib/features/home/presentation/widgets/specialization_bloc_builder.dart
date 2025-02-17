import 'package:appointmentapp/features/home/presentation/widgets/doctors_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/cubit/home_cubit.dart';
import '../../domain/cubit/home_states.dart';
import 'doctor_speciality.dart';
import 'speciality_shimmer.dart';


class SpecializationsBlocBuilder extends StatelessWidget {
  const SpecializationsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) => current is SpecializationLoading || current is SpecializationSuccess || current is SpecializationFailure,
      builder: (context, state) {
        return state.whenOrNull(
              specializationLoading: () => setUpLoading(),
              specializationFailure: (error) => Text(error.getAllErrorMessages()),
              specializationSuccess: (allSpecializations) {
                final specialities = allSpecializations.data;
                return DoctorSpeciality(specialityModels: specialities);
              },
            ) ??
            SizedBox();

      },
    );

  }


  Widget setUpLoading(){
return Column(children: [
  SpecialityShimmer(),
  DoctorsShimmer(),


],);
  }
}
/*  BlocSelector<HomeCubit, HomeStates, List<Doctors>>(
                      selector: (state) => state.maybeWhen(
                        chooseCategorySuccess: (doctors) => doctors,
                        specializationSuccess: (data) => data.data[0].doctors,
                        orElse: () => [],
                        chooseCategoryFailure: (error) {
                          return [];
                        },
                      ),
                      builder: (context, doctors) {
                        return DoctorResultChoice(
                            specialityDoctorsModel: doctors);
                      },
                    ), */