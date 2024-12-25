import '../main.dart';
import '../modules/new_post/new_post_screen.dart';
import '../shared/components/components.dart';
import '../shared/components/widgets/default_textbutton.dart';
import '../shared/cubit/cubit.dart';
import '../shared/styles/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
      if (state is SendEmailVerificationSuccessState) {
        showToast(msg: 'Check your mail', state: ToastStates.success);
      }
      if (state is AddNewPostState) {
        goToPage(page: NewPostScreen(), context: context);
      }
      if (state is ErrorState) {
        showToast(msg: state.error, state: ToastStates.error);
      }
    }, builder: (context, state) {
      final cubit = HomeCubit.get(context);

      return ConditionalBuilder(
        condition: cubit.user != null,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                ValueListenableBuilder<int>(
                  valueListenable: notificationCountNotifier,
                  builder: (context, value, child) => Badge.count(
                    count: notificationCountNotifier.value,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(IconBroken.Notification),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(IconBroken.Search),
                ),
              ],
              title: Text(cubit.currentTitle[cubit.currentIndx]),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (cubit.user!.isEmailVerified == false)
                  Container(
                    color: Colors.amber.withOpacity(0.6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline),
                          const SizedBox(width: 5),
                          const Expanded(
                            child: Text(
                              'Please Verify your email',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(width: 15),
                          DefaultTextButton(
                            onTap: () {
                              //FirebaseAuth.instance.signOut();
                              // cubit.testverify();
                              cubit.sendVerificationEmail();
                            },
                            text: 'send ',
                          )
                          //     Text('Please Verify your email'),
                        ],
                      ),
                    ),
                  ),
                Expanded(child: cubit.currentScreen[cubit.currentIndx]!),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.navItems,
              currentIndex: cubit.currentIndx,
              onTap: (value) {
                cubit.changeNavBottomIndx(value);
              },
            ),
          );
        },
        fallback: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
