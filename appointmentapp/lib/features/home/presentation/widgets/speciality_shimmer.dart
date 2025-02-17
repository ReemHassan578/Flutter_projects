import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';

class SpecialityShimmer extends StatelessWidget {
  const SpecialityShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => horizontalSpace(14),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            spacing: 8.h,
            children: [
              Shimmer.fromColors(
                baseColor: MyColors.lightGreyBorder,
                highlightColor: Colors.white,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 24.w,
                ),
              ),
              Shimmer.fromColors(
                baseColor: MyColors.lightGreyBorder,
                highlightColor: Colors.white,
                child: Expanded(
                  child: Container(
                    height: 8.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.w),),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
//  return   Padding(
//         padding: EdgeInsetsDirectional.only(start: 4 == 0 ? 0 : 24.w),
//         child: Column(children: [
//           Shimmer.fromColors(
//             baseColor: MyColors.grey,
//             highlightColor: Colors.white,
//             child: const CircleAvatar(
//               radius: 28,
//               backgroundColor: Colors.white,
//             ),
//           ),
//           verticalSpace(14),
//           Shimmer.fromColors(
//             baseColor: MyColors.grey,
//             highlightColor: Colors.white,
//             child: Container(
//               height: 14.h,
//               width: 50.w,
//               decoration: BoxDecoration(
//                 color: MyColors.grey,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           )
//         ]));
//   }
// }
