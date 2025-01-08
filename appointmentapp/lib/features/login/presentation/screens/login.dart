import 'package:appointmentapp/core/helpers/spacing.dart';
import 'package:appointmentapp/core/theming/colors.dart';
import 'package:appointmentapp/features/login/presentation/widgets/already_have_account_text.dart';
import 'package:appointmentapp/features/login/presentation/widgets/custom_textformfield.dart';
import 'package:appointmentapp/features/login/presentation/widgets/remember_me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';
import '../widgets/login_button.dart';
import '../widgets/terms_and_conditions_text.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 40.h),
          child: SingleChildScrollView(
            child: Column(
              spacing: 14.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyles.font24BlackBold
                      .copyWith(color: MyColors.bluePrimaryColor),
                ),
                Text(
                  'We\'re excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.',
                  style: TextStyles.font14GreyRegular,
                ),
                verticalSpace(10),
                Form(
                  key: _formKey,
                  child: Column(
                    spacing: 10.h,
                    children: [
                      CustomTextformfield(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            return null;
                          },
                          hintText: 'Email'),
                      CustomTextformfield(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (password) {
                            return null;
                          },
                          isPassword: true,
                          hintText: 'Enter your password'),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const RememberMe(),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forget Password ?',
                        style: TextStyles.font12lightGreyRegular
                            .copyWith(color: MyColors.bluePrimaryColor),
                      ),
                    ),
                  ],
                ),
                const LoginButton(),
                verticalSpace(20),
                Stack(alignment: AlignmentDirectional.center, children: [
                  const Divider(
                    color: MyColors.lightGrey,
                  ),
                  Container(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 4.h),
                      color: Colors.white,
                      child: Text(
                        'Or sign in with',
                        style: TextStyles.font12lightGreyRegular,
                      ))
                ]),
                verticalSpace(20),
                const TermsAndConditionsText(),
                const AlreadyHaveAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
