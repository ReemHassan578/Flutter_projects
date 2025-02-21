import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextStyles {
  static const gTSectraFineRegularFont = 'GT Sectra';


static TextStyle font14greyRegular=TextStyle(
                    color: Color(0xff707070),
                    fontSize: 14.sp,
                  );

static TextStyle font14whiteMedium=TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  );


static TextStyle font16whiteMedium=TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  );

static TextStyle font18whiteMedium=TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  );



  static TextStyle font20WhiteRegular = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle font20WhiteBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );

  
  
  static TextStyle font24WhiteBold = TextStyle(
      fontWeight: FontWeight.bold,
       fontSize: 24.sp, 
       );

        static TextStyle font30WhiteRegular = TextStyle(
      fontWeight: FontWeight.w400,
       fontSize: 30.sp, 
       );
}
