import 'package:appointmentapp/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';
import '../../data/models/all_specialization_response.dart';

class DoctorSpecialityItem extends StatelessWidget {
  final Data specialityModel;
  final int currentIndex;
  final int indexItem;
  const DoctorSpecialityItem(
      {super.key,
      required this.specialityModel,
      required this.currentIndex,
      required this.indexItem});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 74.w,
      child: Column(
        spacing: 8.h,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          indexItem != currentIndex
              ? CircleAvatar(
                  backgroundColor: MyColors.lightGreyBorder,
                  radius: 24.w,
                  child: Icon(
                    Icons.baby_changing_station,
                    size: 28.sp,
                    color: MyColors.redValidateError,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: MyColors.grey, width: 2.w)),
                  child: CircleAvatar(
                    backgroundColor: MyColors.lightGreyBorder,
                    radius: 28.w,
                    child: Icon(
                      Icons.baby_changing_station,
                      size: 32.sp,
                      color: MyColors.redValidateError,
                    ),
                  ),
                ),
          Expanded(
            child: Text(
              specialityModel.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyles.font12lightGreyRegular.copyWith(
                height: 1.1.h,
                color: Colors.black,
                fontWeight: indexItem == currentIndex ?FontWeight.bold: FontWeight.normal  ,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
