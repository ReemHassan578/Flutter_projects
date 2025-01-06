import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';
import '../widgets/doc_logo_and_name.dart';
import '../widgets/doctor_image_and_text.dart';
import '../widgets/get_started_button.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20.h,
              children: [
                const DocLogoAndName(),
                const DoctorImageAndText(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    'Manage and schedule all of your medical appointments easily with Docdoc to get a new experience.',
                    textAlign: TextAlign.center,
                    style: TextStyles.font13GreyRegular,
                  ),
                ),
                const GetStartedButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
