import 'package:appointmentapp/core/helpers/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class DoNotHaveAccountText extends StatelessWidget {
  const DoNotHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                text: 'Don\'t have an account yet?',
                style:
                    TextStyles.font12lightGreyRegular.copyWith(height: 1.5.h),
              ),
              TextSpan(
                text: ' Sign Up ',
                recognizer: TapGestureRecognizer()..onTap=(){              context.pushReplacementNamed(Routes.signUpScreen);
},
                style: TextStyles.font12lightGreyRegular
                    .copyWith(height: 1.5.h, color: MyColors.bluePrimaryColor),
              )
            ])),
       
      ],
    );
  }
}
