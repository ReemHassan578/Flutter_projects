import 'package:books_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../book_rating.dart';



class BookNameAndAuthorText extends StatelessWidget {
  const BookNameAndAuthorText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      //height: 60.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'name',style: TextStyles.font30WhiteRegular.copyWith(height: 1.1.h),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Opacity(
            opacity: 0.7,
            child: Text(
              'author',
              style: TextStyles.font18whiteMedium.copyWith(fontStyle: FontStyle.italic)
            ),
          ),
           BookRating(mainAxisAlignment: MainAxisAlignment.center,),
         
        ],
      ),
    );
  }
}
