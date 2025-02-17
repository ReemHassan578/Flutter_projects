import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class DoctorBlueContainer extends StatelessWidget {
  const DoctorBlueContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              image: DecorationImage(
                  image: AssetImage('assets/images/home_blue_pattern.png'),
                  fit: BoxFit.cover),
            ),
            height: 170.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    spacing: 2.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text('Book and schedule with nearest doctor',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.font18BlackBold.copyWith(
                                height: 1.5.h,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(bottom: 10.h),
                        height: 38.h,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(),
                            onPressed: () {},
                            child: Text(
                              'Find Nearby',
                              style: TextStyles.font12lightGreyRegular
                                  .copyWith(color: MyColors.bluePrimaryColor),
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 100.w,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(end: 8.w),
            child: Image.asset(
              'assets/images/nurse.png',
            ),
          )
        ],
      ),
    );
  }
}
