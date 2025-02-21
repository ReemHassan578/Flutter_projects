import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/text_styles.dart';

class BookRating extends StatelessWidget {
 final MainAxisAlignment mainAxisAlignment;
  const BookRating({super.key,required this.mainAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      //   spacing: 10.w,
      children: [
        Icon(
          Icons.star,
          size: 18.sp,
          color: Colors.amber,
        ),
        Text('256231 ', style: TextStyles.font16whiteMedium),
        Flexible(
          child: Text(
            '(124)',
            overflow: TextOverflow.ellipsis,
            style: TextStyles.font14greyRegular,
          ),
        ),
      ],
    );
  }
}
