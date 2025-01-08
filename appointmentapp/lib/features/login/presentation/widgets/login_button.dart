import 'package:appointmentapp/core/helpers/extensions.dart';
import 'package:appointmentapp/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      padding:
          EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: MyColors.bluePrimaryColor),
      height: 52.h,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(0),
          // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          context.pushReplacementNamed(Routes.loginScreen);
        },
        child: Text('Login', style: TextStyles.font16GreySemiBold),
      ),
    );
  }
}
