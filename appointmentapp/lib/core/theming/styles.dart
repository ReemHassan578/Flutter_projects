import 'package:appointmentapp/core/theming/colors.dart';
import 'package:appointmentapp/core/theming/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static TextStyle font24BlackBold = TextStyle(
    fontSize: 24.sp,
    color: Colors.black,
    fontWeight: FontWeightHelper.bold,
  );
  static TextStyle font32BlueBold = TextStyle(
    fontSize: 32.sp,
    color: MyColors.bluePrimaryColor,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font13GreyRegular = TextStyle(
    fontSize: 13.sp,
    color: MyColors.grey,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font16GreySemiBold = TextStyle(
    fontSize: 16.sp,
    color: Colors.white,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle font14GreyRegular = TextStyle(
    fontSize: 14.sp,
    color: MyColors.grey,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font14lightGreyMedium = TextStyle(
    fontSize: 14.sp,
    color: MyColors.lightGrey,
    fontWeight: FontWeightHelper.medium,
  );
    static TextStyle font14BlackMedium = TextStyle(
    fontSize: 14.sp,
    color: MyColors.blackFormText,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle font12lightGreyRegular = TextStyle(
    fontSize: 12.sp,
    color: MyColors.lightGrey,
    fontWeight: FontWeightHelper.regular,
  );

   static TextStyle font18BlackBold = TextStyle(
    fontSize: 18.sp,
    color: MyColors.black,
    fontWeight: FontWeightHelper.bold,
  );

   static TextStyle font11DarkGreyRegular = TextStyle(
    fontSize: 11.sp,
    color: MyColors.darkGrey,
    fontWeight: FontWeightHelper.regular,
  );
}
