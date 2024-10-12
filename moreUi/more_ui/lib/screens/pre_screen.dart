import 'dart:async';

import 'package:flutter/material.dart';

import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageContent {
  final String title;
  final String image;

  final String description;
  final Icon icon;

  const PageContent(
      {required this.title,
      required this.image,
      required this.description,
      required this.icon});
}

class PreScreen extends StatefulWidget {
  final List<PageContent> _pages = const [
    PageContent(
      title: 'title 1',
      image: 'lib/assets/q1.jpg',
      description: 'This is paragraph for title 1',
      icon: Icon(
        Icons.add,
        size: 80,
      ),
    ),
    PageContent(
        title: 'title 2',
        image: 'lib/assets/q2.jpg',
        description: 'This is paragraph for title 2',
        icon: Icon(
          Icons.add_alarm,
          size: 80,
        )),
    PageContent(
        title: 'title 3',
        image: 'lib/assets/q3.jpg',
        description: 'This is paragraph for title 3',
        icon: Icon(
          Icons.add_alert_rounded,
          size: 80,
        )),
    PageContent(
        title: 'title 4',
        image: 'lib/assets/q4.jpg',
        description: 'This is paragraph for title 4',
        icon: Icon(
          Icons.add_chart_sharp,
          size: 80,
        ))
  ];
  const PreScreen({super.key});

  @override
  State<PreScreen> createState() => _PreScreenState();
}

class _PreScreenState extends State<PreScreen> {
  int currentPage = 0;
  final PageController controllerP = PageController();

  @override
  void initState() {
    super.initState();

    Timer.periodic(
      Duration(seconds: 20),
      (timer) {
        if (_currentPageNotifier.value < 3) {
          _currentPageNotifier.value++;
          controllerP.animateToPage(
              duration: Duration(seconds: 2),
              _currentPageNotifier.value,
              curve: Curves.easeIn);
        }
      },
    );
  }

  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        PageView(
          controller: controllerP,
          onPageChanged: (value) {
            _currentPageNotifier.value = value;
            setState(() {
              // manual       currentPage = value;
            });
            if (value == 3) {
              Future.delayed(
                  const Duration(
                    seconds: 2,
                  ), () async {
                Navigator.of(context).pushNamed('/Splash_Screen');
                final SharedPreferences sharedPreference =
                    await SharedPreferences.getInstance();
                sharedPreference.setBool('first', false);
              });
            }
          },
          children: [
            ...widget._pages.map(
              (e) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(e.image), fit: BoxFit.cover),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        e.icon,
                        const SizedBox(height: 30),
                        Text(e.title,
                            style: Theme.of(context).textTheme.headlineLarge),
                        const SizedBox(height: 10),
                        Text(e.description,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.white)),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
        Column(children: [
          const Spacer(),
          /*  CirclePageIndicator(
            dotColor: Colors.black,
            selectedDotColor: Colors.white,
            itemCount: widget._pages.length,
            currentPageNotifier: _currentPageNotifier,
          ),*/
          PageViewDotIndicator(
            currentItem: _currentPageNotifier.value,
            count: widget._pages.length,
            unselectedColor: Colors.black,
            selectedColor: Colors.white,
            duration: const Duration(milliseconds: 200),
            boxShape: BoxShape.circle,
          ),
          const SizedBox(height: 25),
          Container(
            color: Colors.orange,
            width: double.infinity,
            child: TextButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/Splash_Screen');
                final SharedPreferences sharedPreference =
                    await SharedPreferences.getInstance();
                sharedPreference.setBool('first', false);

                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) {
                //     return SplashScreen();
                //    },
                // ));
              },
              child: const Text(
                'GET STARTED',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ])
      ]),
    ));
  }

  Row manualIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < widget._pages.length; i++)
          if (currentPage != i)
            Container(
              height: 10,
              width: 10,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
            )
          else if (currentPage == i)
            Icon(Icons.star),
      ],
    );
  }
}
    //Scaffold(body: Builder(builder: (context) {
    //   final double height = MediaQuery.of(context).size.height;
    //   return Stack(
    //     children: [
    //       CarouselSlider(
    //         options: CarouselOptions(
    //           onPageChanged: (index, _) {
    //             setState(() {
    //               currentImage = index;
    //             });
    //           },
    //           height: height,
    //           viewportFraction: 1.0,
    //           enlargeCenterPage: false,
    //           autoPlay: true,
    //         ),
    //         items: [
    //           ...imgList.map(
    //             (e) {
    //               return Stack(
    //                 children: [
    //                   Center(
    //                       child: Image.asset(
    //                     e,
    //                     fit: BoxFit.cover,
    //                     height: height,
    //                   )),
    //                   PreScreen.content[currentImage],
    //                 ],
    //               );
    //             },
    //           )
    //         ],
    //       ),
    //       Column(
    //         children: [
    //           Expanded(
    //             child: Row(
    //               children: [
    //                 for (int i = 0; i < imgList.length; i++)
    //                   Container(
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(10),
    //                       color: currentImage == i ? Colors.green : Colors.red,
    //                     ),
    //                     height: 20,
    //                     width: 20,
    //                   ),
    //               ],
    //             ),
    //           ),
    //           Container(
    //               width: double.infinity,
    //               color: Colors.orange,
    //               child: TextButton(
    //                   onPressed: () {},
    //                   child: const Text('GET STARTED',
    //                       style: TextStyle(color: Colors.white))))
    //         ],
    //       )
    //     ],
    //   );
    // }));
