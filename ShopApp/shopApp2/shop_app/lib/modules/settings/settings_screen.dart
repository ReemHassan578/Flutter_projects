import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/widgets/default_textformfield.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../shared/components/widgets/default_elevatedbutton.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        final cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.settings != null,
          builder: (context) {
            final settings = cubit.settings!.data;
            emailController.text = settings!.email;
            nameController.text = settings.name;
            phoneController.text = settings.phone;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (state is LoadingUpdateState)
                        LinearProgressIndicator(),
                      const SizedBox(
                        height: 30,
                      ),
                      DefaultTextFormField(
                          type: TextInputType.name,
                          controller: nameController,
                          label: 'Name',
                          preIcon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name must not be empty';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      DefaultTextFormField(
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          label: 'Email',
                          preIcon: Icons.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email must not be empty';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      DefaultTextFormField(
                          type: TextInputType.phone,
                          controller: phoneController,
                          label: 'Phone',
                          preIcon: Icons.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone must not be empty';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      DefaultElevatedButton(
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.update({
                              'email': emailController.text,
                              'phone': phoneController.text,
                              'name': nameController.text,
                              'image': 'm',
                            });
                          }
                        },
                        text: 'Update',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DefaultElevatedButton(
                        onPress: () {
                          cubit.logoutUser();
                        },
                        text: 'LogOut',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (BuildContext context, AppStates state) {
        if (state is LogoutSuccessState) {
          goToPageAndFinish(page: LoginScreen(), context: context);
        }
        if (state is ErrorState) {
          print(state.error);
          //    print(AppCubit.get(context).settings!.data.email);
          //  print(AppCubit.get(context).settings!.data.phone);

          // print(AppCubit.get(context).settings!.data.name);
        }
      },
    );
  }
}
