import 'package:appointmentapp/features/home/data/models/all_specialization_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../domain/cubit/home_cubit.dart';
import 'doctor_speciality_item.dart';

class DoctorSpeciality extends StatefulWidget {
  final List<Data> specialityModels;
  const DoctorSpeciality({super.key, required this.specialityModels});

  @override
  State<DoctorSpeciality> createState() => _DoctorSpecialityState();
}

class _DoctorSpecialityState extends State<DoctorSpeciality> {
  int indexItemChosen = 0;
  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return SizedBox(
      height: 86.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => horizontalSpace(14),
        scrollDirection: Axis.horizontal,
        itemCount: widget.specialityModels.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                homeCubit.chooseSpeciality(widget.specialityModels[index].id);
              
              setState(() {
                indexItemChosen=index;
              });},
              child: DoctorSpecialityItem( indexItem:indexItemChosen,currentIndex:index,
                  specialityModel: widget.specialityModels[index]));
        },
      ),
    );
  }
}
