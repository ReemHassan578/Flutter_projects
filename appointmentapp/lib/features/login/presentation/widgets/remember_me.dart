import 'package:appointmentapp/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';

class RememberMe extends StatefulWidget {
  const RememberMe({super.key});

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  bool rememberPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          rememberPressed = !rememberPressed;
        });
      },
      child: Container(
        padding: EdgeInsetsDirectional.only(start: 4.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 8.w,
          children: [
            SizedBox(
              height: 18.h,
              width: 18.w,
              child: Checkbox(
                activeColor: MyColors.bluePrimaryColor,
                value: rememberPressed,
                onChanged: (value) {},
                side: const BorderSide(color: MyColors.lightGreyBorder),
              ),
            ),
            Text(
              'Remember me',
              style: TextStyles.font12lightGreyRegular,
            ),
          ],
        ),
      ),
    );
  }
}
