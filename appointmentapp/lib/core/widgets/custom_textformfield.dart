import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class CustomTextformfield extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final String hintText;
  final Widget? prefix;

  final bool isPassword;
  const CustomTextformfield({
    required this.controller,
    super.key,
    required this.keyboardType,
    required this.validator,
    required this.hintText,
    this.isPassword = false,
    this.prefix,
  });

  @override
  State<CustomTextformfield> createState() => _CustomTextformfieldState();
}

class _CustomTextformfieldState extends State<CustomTextformfield> {
  late bool passwordVisible;
  @override
  void initState() {
    super.initState();
    passwordVisible = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        
        controller: widget.controller,
        obscureText: passwordVisible,
        validator: widget.validator,
        cursorColor: MyColors.bluePrimaryColor,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          prefixIcon: widget.prefix,
            isDense: true,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    icon: Icon(
                      !passwordVisible ? Icons.visibility : Icons.visibility_off,
                      size: 24.sp,
                    ),
                  )
                : null,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 17.h),
            filled: true,
            fillColor: MyColors.lightGreyFormFill,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: MyColors.bluePrimaryColor),
              borderRadius: BorderRadius.circular(16.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: MyColors.redValidateError),
              borderRadius: BorderRadius.circular(16.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: MyColors.redValidateError),
              borderRadius: BorderRadius.circular(16.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: MyColors.lightGreyBorder),
              borderRadius: BorderRadius.circular(16.r),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyles.font14lightGreyMedium),
        style: TextStyles.font14BlackMedium,
      ),
    );
  }
}
