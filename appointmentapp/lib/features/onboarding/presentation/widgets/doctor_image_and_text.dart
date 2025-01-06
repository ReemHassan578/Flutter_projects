import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theming/styles.dart';

class DoctorImageAndText extends StatelessWidget {
  const DoctorImageAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 491.h,
      width: 375.w,
      child: Stack(
        children: [
          SizedBox(
            width: 443.w,
            height: 443.h,
            child: SvgPicture.asset(
              'assets/svgs/docdoc_logo_low_opacity.svg',
            ),
          ),
          SizedBox(
            width: 375.w,
            height: 491.h,
            child: Image.asset(
              'assets/images/onboarding_doctor.png',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              width: 375.w,
              height: 239.h,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                      stops: const [
                    0.14,
                    0.7
                  ],
                      colors: [
                    Colors.white.withValues(alpha: 0),
                    Colors.white,
                  ])),
              alignment: AlignmentDirectional.bottomCenter,
              child: Text('Best Doctor Appointment App',
                  textAlign: TextAlign.center,
                  style: TextStyles.font32BlueBold.copyWith(height: 1.4.h)),
            ),
          ),
        ],
      ),
    );
  }
}
