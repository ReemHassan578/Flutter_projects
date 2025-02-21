import 'package:books_app/core/helpers/assets_helper.dart';
import 'package:books_app/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 32.h),
      child: Row(
        children: [
          Image.asset(
            AssetsHelper.logo,
            width: 60.w,
          ),
          Spacer(),
          IconButton(
            style: IconButton.styleFrom(backgroundColor: Colors.transparent),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.searchScreen);
            },
            icon: Icon(
              Icons.search,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}
