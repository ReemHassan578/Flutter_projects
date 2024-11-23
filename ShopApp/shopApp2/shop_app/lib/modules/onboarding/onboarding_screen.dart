import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/onboarding/cubit/cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/widgets/default_textbutton.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'cubit/states.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: BlocConsumer<OnBoardingCubit, OnBoardingStates>(
        listener: (context, state) {
          if (state is ErrorState) {
            showToast(msg: 'Error in prefs', state: ToastStates.error);
          }
          if (state is ReachEndState) {
            goToPageAndFinish(page: LoginScreen(), context: context);
          }
        },
        builder: (context, state) {
          final cubit = OnBoardingCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                DefaultTextButton(
                    onTap: () async {
                      await cubit.reachEnd();
                    },
                    text: 'skip'),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (value) {
                        if ((value) == cubit.boardingItems.length - 1) {
                          cubit.setIsLastReached(true);
                        } else {
                          cubit.setIsLastReached(false);
                        }
                      },
                      controller: pageController,
                      itemCount: cubit.boardingItems.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildBoardingItem(cubit.boardingItems[index]);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SmoothPageIndicator(
                        controller: pageController, // PageController
                        count: cubit.boardingItems.length,
                        effect: const WormEffect(
                          dotColor: Colors.grey,
                          activeDotColor: defaultColor,
                        ),
                      ),
                      const Spacer(),
                      FloatingActionButton(
                        onPressed: () {
                          if (cubit.isLast) {
                            cubit.reachEnd();

                            //  Navigator.pushAndRemoveUntil(
                            //  context,
                            ///MaterialPageRoute(
                            //   builder: (context) => LoginScreen(),
                            //  ),
                            //   (route) => false,
                            // );
                          } else {
                            pageController.nextPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn);
                          }
                        },
                        child: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBoardingItem(BoardItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(
            item.image,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          item.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          item.body,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class BoardItem {
  final String image;
  final String title;
  final String body;

  const BoardItem(
      {required this.image, required this.title, required this.body});
}
