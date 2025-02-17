import 'package:appointmentapp/features/home/domain/cubit/home_cubit.dart';
import 'package:appointmentapp/features/home/domain/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'doctor_result_choice.dart';

class DoctorsResultBuilder extends StatelessWidget {
  const DoctorsResultBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) =>
          current is ChooseCategorySuccess || current is ChooseCategoryFailure,
      builder: (context, state) => state.maybeWhen(
        orElse: () => SizedBox(),
        chooseCategoryFailure: (error) => Text(error.getAllErrorMessages()),
        chooseCategorySuccess: (doctors) => DoctorResultChoice(
            specialityDoctorsModel: context.read<HomeCubit>().currentDoctors!),
      ),
    );
  }
}
