import 'package:appointmentapp/core/helpers/extensions.dart';
import 'package:appointmentapp/core/helpers/spacing.dart';
import 'package:appointmentapp/core/theming/colors.dart';

import 'package:appointmentapp/features/signup/domain/cubit/register_cubit.dart';
import 'package:appointmentapp/features/signup/domain/cubit/register_states.dart';
import 'package:appointmentapp/features/signup/presentation/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theming/styles.dart';
import '../../../../../../core/widgets/button.dart';
import '../../../../core/routing/routes.dart';
import '../../../login/presentation/widgets/terms_and_conditions_text.dart';
import '../widgets/already_have_account_text.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                  'Create Account',
                  style: TextStyles.font24BlackBold
                      .copyWith(color: MyColors.bluePrimaryColor),
                ),
                Text(
                  "Sign up now and start exploring all that our app has to offer. We're excited to welcome you to our community!",
                  style: TextStyles.font14GreyRegular,
                ),
                verticalSpace(10),
                const SignUpForm(),
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
                          .read<RegisterCubit>()
                          .formKey
                          .currentState!
                          .validate()) {
                        context.read<RegisterCubit>().register();
                      }
                    },
                    child: Text('Create Account',
                        style: TextStyles.font16GreySemiBold),
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
                const AlreadyHaveAccountText(),
                buildBlocLister(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBlocLister() {
    return BlocListener<RegisterCubit, RegisterStates>(
      listenWhen: (previous, current) {
        return (current is Loading || current is Success || current is Failure);
      },
      listener: (context, state) {
        state.whenOrNull(
          success: (data) {
            context.pop();
            final alertDialog = AlertDialog(
              content: const Text('Done'),
              actions: [
                TextButton(
                    onPressed: () {
                      context.pop();
                      context.pushNamed(Routes.loginScreen);
                    },
                    child: const Text('login'))
              ],
            );
            showDialog(
              context: context,
              builder: (context) => alertDialog,
            );
          },
          failure: (error) {
            final alertDialog = AlertDialog(
              icon: Icon(
                Icons.error,
                size: 26.sp,
              ),
              iconColor: MyColors.redValidateError,
              content: Text(error),
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
