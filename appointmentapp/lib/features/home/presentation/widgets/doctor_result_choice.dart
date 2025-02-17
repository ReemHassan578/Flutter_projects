import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../data/models/all_specialization_response.dart';

class DoctorResultChoice extends StatelessWidget {
  final List<Doctors> specialityDoctorsModel;
  const DoctorResultChoice({super.key, required this.specialityDoctorsModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          itemCount: specialityDoctorsModel.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            height: 126.h,
            child: Row(
              spacing: 20.w,
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.w),
                    //  color: Colors.amber,
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWjwYSYjlzyrnNwk7mYkNNj2rm04BVlGlQuw&s',
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                    width: 110.w,
                    height: 110.h,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        specialityDoctorsModel[index].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.font16GreySemiBold
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        '${specialityDoctorsModel[index].specialization.name}  |  ${specialityDoctorsModel[index].phone} ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.font12lightGreyRegular
                            .copyWith(color: MyColors.darkGrey),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 24.sp,
                            color: Colors.amber,
                          ),
                          Text(
                            '4  (4,279 reviews)',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.font12lightGreyRegular
                                .copyWith(color: MyColors.darkGrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
