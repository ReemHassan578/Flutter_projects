import 'package:appointmentapp/features/signup/presentation/widgets/password_field_and_validation_bullets.dart';
import 'package:appointmentapp/features/signup/presentation/widgets/phone_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/app_regex.dart';
import '../../../../core/widgets/custom_textformfield.dart';
import '../../domain/cubit/register_cubit.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<RegisterCubit>().formKey,
      child: Column(
        spacing: 10.h,
        children: [
          CustomTextformfield(
              controller: context.read<RegisterCubit>().emailController,
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
        const  PhoneTextField(),
          const PasswordFieldAndValidationBullets(),
        ],
      ),
    );
  }
}
