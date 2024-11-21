import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  final boardingItems = const [
    BoardItem(
        image: 'assets/images/shop1.jpg',
        title: 'On Board 1 Title',
        body: 'On Board 1 body'),
    BoardItem(
        image: 'assets/images/shop2.jpg',
        title: 'On Board 2 Title',
        body: 'On Board 2 body'),
    BoardItem(
        image: 'assets/images/shop1.jpg',
        title: 'On Board 3 Title',
        body: 'On Board 3 body'),
  ];
  OnBoardingScreen({super.key});
  bool isLast = false;
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
                },
                child: Text('SKIP'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    if ((value) == boardingItems.length - 1) {
                      isLast = true;
                    } else {
                      isLast = false;
                    }
                  },
                  controller: pageController,
                  itemCount: boardingItems.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildBoardingItem(boardingItems[index]);
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
                    count: boardingItems.length,
                    effect: const WormEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
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
        ));
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
