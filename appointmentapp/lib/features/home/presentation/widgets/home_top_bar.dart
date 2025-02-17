import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, username',
              style: TextStyles.font18BlackBold,
            ),
            Text(
              'How are you today',
              style: TextStyles.font11DarkGreyRegular,
            ),
          ],
        ),
        Spacer(), 
        CircleAvatar(
          radius: 24.r,
          backgroundColor: MyColors.lightGreyBorder,
          child: Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.black,
                  size: 24.sp,
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                  child: CircleAvatar(
                    backgroundColor: MyColors.redValidateError,
                    radius: 4.r,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
