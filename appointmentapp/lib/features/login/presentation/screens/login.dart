import 'package:appointmentapp/core/helpers/extensions.dart';
import 'package:appointmentapp/core/helpers/spacing.dart';
import 'package:appointmentapp/core/theming/colors.dart';
import 'package:appointmentapp/features/login/domain/cubit/login_cubit.dart';
import 'package:appointmentapp/features/login/domain/cubit/login_states.dart';
import 'package:appointmentapp/features/login/presentation/widgets/do_not_have_account_text.dart';
import 'package:appointmentapp/features/login/presentation/widgets/remember_me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/button.dart';
import '../widgets/email_and_password.dart';
import '../widgets/terms_and_conditions_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
          const      EmailAndPassword(),
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
                Button(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 12.w, vertical: 12.h),
                  button: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      if (context
                          .read<LoginCubit>()
                          .formKey
                          .currentState!
                          .validate()) {
                       
                        context
                            .read<LoginCubit>()
                            .emitLoginState();
                      }
                    },
                    child: Text('Login', style: TextStyles.font16GreySemiBold),
                  ),
                ),
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
                const DoNotHaveAccountText(),
                buildBlocLister(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBlocLister() {
    return BlocListener<LoginCubit, LoginStates>(
      listenWhen: (previous, current) {
        return (current is Loading || current is Success || current is Failure);
      },
      listener: (context, state) {
        state.whenOrNull(
          success: (data) {
            context.pop();

             context.pushNamed(Routes.homeScreen);
          },
          failure: (error) {
            final alertDialog = AlertDialog(
              icon: Icon(
                Icons.error,
                size: 26.sp,
              ),
              iconColor: MyColors.redValidateError,
              content: Text(error.getAllErrorMessages()),
              actions: [
                TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('Got It'))
              ],
            );
            context.pop();
            showDialog(
              context: context,
              builder: (context) => alertDialog,
            );
          },
          loading: () {
            showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
