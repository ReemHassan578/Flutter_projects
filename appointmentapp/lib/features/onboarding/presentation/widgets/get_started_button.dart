import 'package:appointmentapp/core/helpers/extensions.dart';
import 'package:appointmentapp/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: MyColors.bluePrimaryColor),
      height: 52.h,
      width: 311.w,
      child: TextButton(
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          context.pushNamed(Routes.loginScreen);
        },
        child: Text('Get Started', style: TextStyles.font16Grey600Weight),
      ),
    );
  }
}
