import 'package:appointmentapp/features/home/presentation/widgets/doctors_result_bloc_builder.dart';
import 'package:appointmentapp/features/home/presentation/widgets/home_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/doctor_blue_container.dart';
import '../widgets/doctor_speciality_header.dart';
import '../widgets/specialization_bloc_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Column(
              spacing: 10.h,
              children: const[
                HomeTopBar(),
                DoctorBlueContainer(),
                DoctorSpecialityHeader(),
                SpecializationsBlocBuilder(),
              DoctorsResultBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }

 
}
