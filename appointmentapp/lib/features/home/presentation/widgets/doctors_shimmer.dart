import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../data/models/all_specialization_response.dart';

class DoctorsShimmer extends StatelessWidget {
  const DoctorsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        height: 126.h,
        child: Row(
          spacing: 20.w,
          children: [
            Shimmer.fromColors(
              baseColor: MyColors.lightGreyBorder,
              highlightColor: Colors.white,
              child: Container(
                height: 110.h,
                width: 110.w,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: MyColors.black,
                  borderRadius: BorderRadius.circular(12.w),
                ),
                child: SizedBox(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                child: Column(
                  spacing: 12.h,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Shimmer.fromColors(
                      baseColor: MyColors.lightGreyBorder,
                      highlightColor: Colors.white,
                      child: Container( 
                        height: 20.h,
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.w),color: Colors.white),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: MyColors.lightGreyBorder,
                      highlightColor: Colors.white,
                      child: Container(
                        height: 15.h,
                        width:double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.w),color: Colors.white),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: MyColors.lightGreyBorder,
                      highlightColor: Colors.white,
                      child: Container(
                        height: 15.h,
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.w),color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
