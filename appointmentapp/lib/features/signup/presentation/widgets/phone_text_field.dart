import 'package:appointmentapp/core/helpers/app_regex.dart';
import 'package:appointmentapp/core/widgets/custom_textformfield.dart';
import 'package:appointmentapp/features/signup/domain/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextformfield(
        prefix: DropdownButtonHideUnderline(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.w),
            child: DropdownButton(
              items:const [
                 DropdownMenuItem(
                  child: Icon(Icons.flag),
                ),
              ],
              onChanged: (value) {},
            ),
          ),
        ),
        controller: context.read<RegisterCubit>().phoneController,
        keyboardType: TextInputType.phone,
        validator: (phone) {
          if (phone == null ||
              phone.trim().isEmpty ||
              !AppRegex.isPhoneValid(phone)) {
            return 'enter valid phone';
          }
          return null;
        },
        hintText: 'enter phone');
  }
}
