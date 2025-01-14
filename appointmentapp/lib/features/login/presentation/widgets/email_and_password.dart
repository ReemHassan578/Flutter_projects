
import 'package:appointmentapp/features/login/domain/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/app_regex.dart';
import '../../../../core/widgets/custom_textformfield.dart';
import 'password_field_and_validation_bullets.dart';

class EmailAndPassword extends StatelessWidget {
const  EmailAndPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        spacing: 10.h,
        children: [
          CustomTextformfield(
              controller: context.read<LoginCubit>().emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (email) {
                if (email == null ||
                    email.trim().isEmpty ||
                    !AppRegex.isEmailValid(email)) {
                  return 'enter a valid email';
                }
                return null;
              },
              hintText: 'Email'),
          const PasswordFieldAndValidationBullets()
        ],
      ),
    );
  }

 
}
