import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/widgets/default_elevatedbutton.dart';
import 'package:shop_app/shared/components/widgets/default_textformfield.dart';

import '../../layout/layout_Screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/widgets/default_textbutton.dart';
import '../../shared/cubit/cubit.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              padding: const EdgeInsets.all(20.0),
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
                          'Login to browse our hot offers',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
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
                        const SizedBox(
                          height: 20,
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
                        const SizedBox(
                          height: 40,
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
                        const SizedBox(
                          height: 15,
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
            showToast(msg: state.msg, state: ToastStates.success);

            goToPageAndFinish(context: context, page: const HomeScreen()).then(
              (value) {
                if (mounted) {
                  BlocProvider.of<AppCubit>(context)
                    ..getFavorites()
                    ..getSettings()
                    ..getHomeProduct();
                }
              },
            );
          }
        },
      ),
    );
  }
}
