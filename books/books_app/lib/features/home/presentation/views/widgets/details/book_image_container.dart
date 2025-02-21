import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookImageContainer extends StatelessWidget {
  const BookImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: 160.w,
                  height: 280.h,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                  child: Image.network(
                    'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
                    fit: BoxFit.cover,
                  ),
                );
  }
}