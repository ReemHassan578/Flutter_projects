import 'package:appointmentapp/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static TextStyle font24Black700Weight = TextStyle(
    fontSize: 24.sp,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );
  static TextStyle font32BlueBold = TextStyle(
    fontSize: 32.sp,
    color: MyColors.bluePrimaryColor,
    fontWeight: FontWeight.w700,
  );

  static TextStyle font13GreyRegular = TextStyle(
    fontSize: 13.sp,
    color: MyColors.grey,
    fontWeight: FontWeight.normal,
  );
  static TextStyle font16Grey600Weight = TextStyle(
    fontSize: 16.sp,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
}
