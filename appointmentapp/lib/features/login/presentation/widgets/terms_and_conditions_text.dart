import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text:
              'By logging, you agree to our  Terms & Conditions and PrivacyPolicy.',
          style: TextStyles.font12lightGreyRegular.copyWith(height: 1.5.h),
        ),
        TextSpan(
          text: ' Terms & Conditions ',
          style: TextStyles.font12lightGreyRegular
              .copyWith(color: Colors.black)
              .copyWith(height: 1.5.h),
        ),
        TextSpan(
          text: ' and ',
          style: TextStyles.font12lightGreyRegular.copyWith(height: 1.5.h),
        ),
        TextSpan(
          text: ' PrivacyPolicy ',
          style: TextStyles.font12lightGreyRegular
              .copyWith(color: Colors.black)
              .copyWith(height: 1.5.h),
        )
      ]),
    );
  }
}
