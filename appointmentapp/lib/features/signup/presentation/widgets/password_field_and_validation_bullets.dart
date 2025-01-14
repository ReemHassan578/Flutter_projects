import 'package:appointmentapp/features/signup/domain/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/custom_textformfield.dart';

class PasswordFieldAndValidationBullets extends StatefulWidget {
  const PasswordFieldAndValidationBullets({super.key});

  @override
  State<PasswordFieldAndValidationBullets> createState() =>
      _PasswordFieldAndValidationBulletsState();
}

class _PasswordFieldAndValidationBulletsState
    extends State<PasswordFieldAndValidationBullets> {
  bool containUpperLetter = false;
  bool containNumber = false;
  bool containLowerLetter = false;
  bool containSymbol = false;
  bool exceedMinLength = false;

  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = context.read<RegisterCubit>().passwordController;
    passwordController.addListener(
      () {
        setState(() {
          containNumber = AppRegex.hasNumber(passwordController.text);
          containLowerLetter = AppRegex.haslowerLetter(passwordController.text);
          containUpperLetter = AppRegex.hasUpperLetter(passwordController.text);
          containSymbol = AppRegex.hasSpeacialChar(passwordController.text);
          exceedMinLength = AppRegex.has8DigitsOrMore(passwordController.text);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextformfield(
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            validator: (password) {
              if (password == null ||
                  password.trim().isEmpty ||
                  !AppRegex.isPasswordValid(password)) {
                return 'enter a valid password';
              }
              return null;
            },
            isPassword: true,
            hintText: 'Enter your password'),
        verticalSpace(20),
        buildValidationBullets(),
      ],
    );
  }

  Widget buildValidationBullets() {
    return Column(
      spacing: 4.h,
      children: [
        buildSingleRowValidation('At Least 1 number', containNumber),
        buildSingleRowValidation('At least 1 special character', containSymbol),
        buildSingleRowValidation(
            'At least 1 uppercase letter', containUpperLetter),
        buildSingleRowValidation(
            'At least 1 lowercase letter', containLowerLetter),
        buildSingleRowValidation('At least 8 characters', exceedMinLength),
      ],
    );
  }

  buildSingleRowValidation(String validation, bool isValid) {
    return Row(
      spacing: 4.w,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: MyColors.grey,
          ),
        ),
        Text(
          validation,
          style: TextStyles.font13GreyRegular.copyWith(
              decoration: isValid ? TextDecoration.lineThrough : null,
              decorationColor: Colors.green,
              decorationThickness: 2,
              color: isValid ? MyColors.lightGrey : MyColors.blackFormText),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
  }
}
