import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom:32.h),
      child: Row(
        children: [
          IconButton(
            style: IconButton.styleFrom(backgroundColor: Colors.transparent),
            onPressed: () {},
            icon: Icon(Icons.close
            ,
            size: 20.sp,
            ),
          ),
          Spacer(),
          IconButton(
            style: IconButton.styleFrom(backgroundColor: Colors.transparent),
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_outlined
            ,
            size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}
