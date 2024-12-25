import 'package:chat2/modules/login/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/components/components.dart';
import '../../shared/components/widgets/default_elevatedbutton.dart';
import '../../shared/components/widgets/default_textbutton.dart';
import '../../shared/components/widgets/default_textformfield.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        builder: (context, state) {
          final cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: theme.textTheme.headlineMedium,
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        DefaultTextFormField(
                          validator: (value) {
                            if (emailController.text.trim().isEmpty) {
                              return 'Enter valid Email address';
                            } else {
                              return null;
                            }
                          },
                          controller: emailController,
                          label: 'Email Address',
                          preIcon: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        DefaultTextFormField(
                          sufPress: () {
                            cubit.togglePassword();
                          },
                          sufIcon: cubit.isPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off,
                          validator: (value) {
                            if (passwordController.text.trim().isEmpty) {
                              return 'password is too short';
                            } else {
                              return null;
                            }
                          },
                          isPassword: cubit.isPassword,
                          controller: passwordController,
                          label: ' Password',
                          preIcon: Icons.lock,
                          type: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoadingLoginState,
                          builder: (context) => DefaultElevatedButton(
                              text: 'login',
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.loginUser(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account ?',
                              style: theme.textTheme.labelSmall,
                            ),
                            DefaultTextButton(
                              onTap: () {
                                goToPage(
                                    page: RegisterScreen(), context: context);
                              },
                              text: 'Register',
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(msg: state.error, state: ToastStates.error);
          }
          if (state is LoginSucessState) {
            // ScaffoldMessenger.of(context)
            //   .showSnackBar(SnackBar(content: Text('errr')));
            //   showToast(msg: state.msg, state: ToastStates.success);

            //    goToPageAndFinish(context: context, page: const HomeScreen()).then(
            //    (value) {},
            //);
          }
        },
      ),
    );
  }
}
