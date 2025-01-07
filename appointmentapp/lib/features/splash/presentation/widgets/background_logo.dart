import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackgroundLogo extends StatelessWidget {
  const BackgroundLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 443.w,
      height: 443.h,
      child: SvgPicture.asset(
        'assets/svgs/docdoc_logo_low_opacity.svg',
      ),
    );
  }
}
