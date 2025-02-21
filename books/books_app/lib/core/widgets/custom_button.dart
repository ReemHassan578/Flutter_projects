import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final bool isBorderRadiusLeft;
  final void Function()? onPressed;
  final Color backGroundColor;
  final Text text;
  const CustomButton(
      {super.key,
      required this.isBorderRadiusLeft,
      this.onPressed,
      required this.text, required this.backGroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color:backGroundColor,
        borderRadius: isBorderRadiusLeft
            ? BorderRadius.only(
                bottomLeft: Radius.circular(8.w),
                topLeft: Radius.circular(8.w),
              )
            : BorderRadius.only(
                bottomRight: Radius.circular(8.w),
                topRight: Radius.circular(8.w),
              ),
      ),
      child: TextButton(onPressed: onPressed, child: text),
    );
  }
}
