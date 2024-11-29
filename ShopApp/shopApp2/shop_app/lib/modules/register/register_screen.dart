import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/components/widgets/default_elevatedbutton.dart';
import '../../shared/components/widgets/default_textbutton.dart';
import '../../shared/components/widgets/default_textformfield.dart';
import '../../shared/cubit/cubit.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        builder: (context, state) {
          final cubit = RegisterCubit.get(context);
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
                          'Register',
                          style: theme.textTheme.headlineMedium,
                        ),
                        Text(
                          'Register to browse our hot offers',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        DefaultTextFormField(
                          validator: (value) {
                            if (nameController.text.trim().isEmpty) {
                              return 'Enter valid name address';
                            } else {
                              return null;
                            }
                          },
                          controller: nameController,
                          label: 'User Name',
                          preIcon: Icons.person,
                          type: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
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
                          height: 20,
                        ),
                        DefaultTextFormField(
                          validator: (value) {
                            if (phoneController.text.trim().isEmpty) {
                              return 'Enter valid phone address';
                            } else {
                              return null;
                            }
                          },
                          controller: phoneController,
                          label: 'Phone',
                          preIcon: Icons.phone,
                          type: TextInputType.phone,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoadingLoginState,
                          builder: (context) => DefaultElevatedButton(
                              text: 'register',
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.registerUser(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              }),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is RegisterErrorState) {
            showToast(msg: state.error, state: ToastStates.error);
          }
          if (state is RegisterSucessState) {
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
