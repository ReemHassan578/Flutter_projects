import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';

class Button extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final double? width;
  final Widget button;
  const Button(
      {super.key,
      this.padding,
      this.width,
      required this.button});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: MyColors.bluePrimaryColor),
      height: 52.h,
      width: width?.w ?? double.infinity,
      child: button
    );
  }
}
