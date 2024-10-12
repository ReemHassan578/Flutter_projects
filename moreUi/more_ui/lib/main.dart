import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:more_ui/screens/pre_screen.dart';
import 'package:more_ui/screens/splash_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'my_color.dart';
import 'providers/theme.dart';
import 'package:marquee/marquee.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: TestNavBar()));
}

class TestNavBar extends StatefulWidget {
  const TestNavBar({super.key});
  final List<String> title = const ['Home', 'Favorite', 'Search', 'Person'];
  final List<Widget> tabs = const [
    Center(
      child: Text('Home'),
    ),
    Center(
      child: Text('Favorite'),
    ),
    Center(
      child: Text('Search'),
    ),
    Center(
      child: Text('Person'),
    ),
  ];
  @override
  State<TestNavBar> createState() => _TestNavBarState();
}

class _TestNavBarState extends State<TestNavBar> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(widget.title[currentTab])),
        body: widget.tabs[currentTab],
        bottomNavigationBar: Container(
          color: Colors.black,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GNav(
                onTabChange: (value) {
                  setState(() {
                    currentTab = value;
                  });
                },
                padding: const EdgeInsets.all(8.0),
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.favorite_border,
                    text: 'Favorite',
                  ),
                  GButton(icon: Icons.search, text: 'Search'),
                  GButton(icon: Icons.person, text: 'Person'),
                ],
                activeColor: Colors.pink,
                gap: 2,
                tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2))],
                tabBorder: Border.all(color: Colors.grey),
                tabActiveBorder: Border.all(color: Colors.pink),
                duration: const Duration(microseconds: 600),
                tabBorderRadius: 50,
                iconSize: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextInherited extends StatefulWidget {
  const TextInherited({super.key});

  @override
  State<TextInherited> createState() => _TextInheritedState();
}

class _TextInheritedState extends State<TextInherited> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Demo'),
        ),
        body: Column(
          children: [
            Center(
              child: Builder(builder: (context) {
                return MyColor(
                  color: Colors.blue,
                  child: Builder(builder: (context) {
                    return Column(
                      children: [
                        const Text(
                          'My Text',
                          style: TextStyle(
                            fontSize: 45,
                          ),
                        ),
                        Text(
                          'My Text',
                          style: TextStyle(
                              fontSize: 45,
                              backgroundColor: MyColor.of(context).color),
                        ),
                      ],
                    );
                  }),
                );
              }),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {});
                  log('set state rebuild');
                },
                child: const Text('press'))
          ],
        ),
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Future<bool?> firstTime() async {
    final SharedPreferences sharedPreference =
        await SharedPreferences.getInstance();
    return sharedPreference.getBool('first');
  }

  @override
  Widget build(BuildContext context, ref) {
    var theme = ref.watch(themeProvider);
    return MaterialApp(
        routes: {
          '/Pre_Screen': (cntx) => const PreScreen(),
          '/Splash_Screen': (cntx) => const SplashScreen()
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme,
        home: Builder(builder: (context) {
          return FutureBuilder(
            future: firstTime(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              } else if (snapshot.hasData) {
                return const HomeScreen();
              } else if ((!snapshot.hasData)) {
                return const PreScreen();
              }

              return const SplashScreen();
            },
          );
        })
        // const PreScreen(),
        );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  Color pickedcolor = Colors.teal;
  void showTast(context) {
    showToast(
      'This is normal toast with animation',
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position:
          const StyledToastPosition(offset: 40, align: Alignment.bottomCenter),
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }

  void showAlrt(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (cntx) {
        return AlertDialog(
          title: const Text('Dialog Title'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('ok'))
          ],
          content: const SizedBox(
              height: 100,
              child: Column(
                children: [
                  Divider(
                    color: Colors.black,
                  ),
                  Text('NOOOOOOOOOOO'),
                ],
              )),
        );
      },
    );
  }

  String str = 'Flutter Demo';
  List<String> images = [
    'lib/assets/s1.jpg',
    'lib/assets/s2.jpg',
    'lib/assets/s3.jpg',
  ];

  bool switchValue = false;

  Widget buildSwitch() {
    return Switch(
      value: switchValue,
      onChanged: (value) {
        showDialog(
            context: context,
            builder: (cntx) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlockPicker(
                          pickerColor: pickedcolor,
                          onColorChanged: (value) {
                            setState(() {
                              pickedcolor = value;
                            });
                          }),
                      ColorPicker(
                        pickerColor:
                            ref.watch(themeProvider).scaffoldBackgroundColor,
                        onColorChanged: (value) {
                          ref
                              .read(themeProvider.notifier)
                              .setScaffoldColor(value);
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Got it'),
                      ),
                    ],
                  ),
                ),
              );
            });

        //  setState(() {
        //     switchValue = value;
        //  });
        //   switchValue
        //     ? ref.read(themeProvider.notifier).setLightMode()
        //   : ref.read(themeProvider.notifier).setDarkMode();
      },
    );
  }

  late List<Widget> page;
  int currentindex = 0;
  List<String> list = List.generate(
    20,
    (index) {
      return 'Item Num $index';
    },
  );
  @override
  void initState() {
    super.initState();
    page = [
      Center(
        child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      content: SingleChildScrollView(
                          child: Column(children: [
                    BlockPicker(
                      pickerColor:
                          ref.watch(themeProvider).scaffoldBackgroundColor,
                      onColorChanged: (value) {
                        ref
                            .read(themeProvider.notifier)
                            .setScaffoldColor(value);
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Got it'),
                    ),
                  ])));
                },
              );
            },
            child: const Text('Block')),
      ),
      Center(
        child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      content: SingleChildScrollView(
                          child: Column(children: [
                    MaterialPicker(
                      pickerColor:
                          ref.watch(themeProvider).scaffoldBackgroundColor,
                      onColorChanged: (value) {
                        ref
                            .read(themeProvider.notifier)
                            .setScaffoldColor(value);
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Got it',
                        style: TextStyle(
                            color: useWhiteForeground(ref
                                    .watch(themeProvider)
                                    .scaffoldBackgroundColor)
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ])));
                },
              );
            },
            child: const Text('Material')),
      ),
      Center(
        child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      content: SingleChildScrollView(
                          child: Column(children: [
                    SlidePicker(
                      pickerColor:
                          ref.watch(themeProvider).scaffoldBackgroundColor,
                      onColorChanged: (value) {
                        ref
                            .read(themeProvider.notifier)
                            .setScaffoldColor(value);
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Got it'),
                    ),
                  ])));
                },
              );
            },
            child: const Text('HSV')),
      )
    ];
  }

  Widget buildDefaultTabController() {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(str),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'block'),
                Tab(text: 'Meterial'),
                Tab(text: 'HSV'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              page[0],
              page[1],
              page[2],
            ],
          ),

          /*CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('Flutter Demo'),
              backgroundColor: Colors.amber,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              //body
            
            ]))
          ],
        )*/
        ));
  }

  Widget buildIndicator() {
    return CircularPercentIndicator(
      radius: 60.0,
      lineWidth: 5.0,
      percent: 0.5,
      center: const Text("100%"),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.green,
    );
  }

  Widget buildSplash() {
    return EasySplashScreen(
      logo: Image.network(
          'https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-512.png'),
      title: const Text(
        "Title",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: const Text("Loading..."),
      //  futureNavigator: Future(() {
      //  return buildScaffold();
      // }),
    );
  }

//ListWheelScrollView like scrolling wheel

  Widget buildScaffold() {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Demo'),
        ),
        body: Center(
            child: Container(
          height: 500,
          child: InteractiveViewer(
            child: Image.asset(
              'lib/assets/s2.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ))

        /*  ListView.builder(
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Dismissible(
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                return true;
                //await showDialog(
                //   context: context,
                //   builder: (context) => AlertDialog(),
                // );
              } else {
                return false;
              }
            },
            onDismissed: (direction) {
              setState(() {
                list.remove(list[index]);
              });
            },
            key: ValueKey(list[index]),
            child: Card(
              child: SizedBox(
                height: 50,
                child: Center(child: Text(list[index])),
              ),
            ),
          );
        },
        itemCount: list.length,
      ), */
        );
  }

  Marquee buildMarquee() {
    return Marquee(
      text: 'There once was a boy who told this story about a boy: "',
      style: const TextStyle(fontWeight: FontWeight.bold),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20.0,
      velocity: 100.0,
      pauseAfterRound: const Duration(seconds: 1),
      startPadding: 10.0,
      accelerationDuration: const Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: const Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
    );
  }

  ExpansionTile buildExpansionTile(
    String title,
    Map<String, Function()> optionsss,
  ) {
    return ExpansionTile(
      title: Text(title),
      children: [
        const Divider(
          color: Colors.amber,
        ),
        ...optionsss.entries.map((e) {
          return ListTile(
            title: Text(e.key),
            onTap: e.value,
          );
        }),
      ],
    );
  }

  DropdownButton<Object> dropDown() {
    return DropdownButton(
      hint: const Text('  Select '),
      value: option,
      items: [
        ...options.map(
          (e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          },
        )
      ],
      onChanged: (value) {
        setState(() {
          option = value;
        });
      },
    );
  }

  Object? option;
  List<String> options = ['A', 'B', 'C', 'D', 'E', 'F'];
  Widget buildCheck(String option, bool? checker, Function(bool?) setchecker) {
    return CheckboxListTile(
        title: Text(option),
        controlAffinity: ListTileControlAffinity.leading,
        value: checker,
        onChanged: setchecker);
  }

  bool? pressCheck1 = false;
  bool? pressCheck2 = false;
  Widget buildradioListTile(String value, String res) {
    return RadioListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(value),
        value: value,
        groupValue: radioValue,
        onChanged: (value) {
          setState(() {
            radioValue = value;

            result = res;
            colorResult = result == 'wrong answer' ? Colors.red : Colors.green;
          });
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(result),
                backgroundColor: colorResult,
              );
            },
          );
        });
  }

  String? radioValue;
  CarouselSlider imageSliderBuildler() {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            width: double.infinity,
            child: Image.asset(
              images[index],
              fit: BoxFit.cover,
            ));
      },
      options: CarouselOptions(initialPage: 2),
    );
  }

  Widget radioColumn() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            'Guess the answer  2+2 =  ??',
            style: TextStyle(
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          oneOtion('3', 'wrong answer'),
          oneOtion('4', 'right answer'),
          oneOtion('5', 'wrong answer'),
        ],
      ),
    );
  }

  String result = 'wrong answer';
  Color colorResult = Colors.red;

  ListTile oneOtion(String value, String res) {
    return ListTile(
      leading: Radio(
          value: value,
          groupValue: radioValue,
          onChanged: (value) {
            setState(() {
              radioValue = value;

              result = res;
              colorResult =
                  result == 'wrong answer' ? Colors.red : Colors.green;
            });
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(result),
                  backgroundColor: colorResult,
                );
              },
            );
          }),
      title: Text(value),
    );
  }

  void showFlushbar(BuildContext context) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.amber,
      icon: const Icon(Icons.info),
      mainButton: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.exit_to_app)),
      title: "Hey Ninja",
      message:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
    ).show(context);
  }

  void showSnckBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Snakbarrrrrrrrr'),
      action: SnackBarAction(label: 'Press', onPressed: () {}),
    ));
  }

  Widget textAtt() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SelectableText(
            'use jhgvbkljhbnm',
            showCursor: true,
            contextMenuBuilder: (context, editableTextState) {
              return AdaptiveTextSelectionToolbar.buttonItems(
                anchors: editableTextState.contextMenuAnchors,
                buttonItems: <ContextMenuButtonItem>[
                  ContextMenuButtonItem(
                    onPressed: () {
                      editableTextState
                          .cutSelection(SelectionChangedCause.toolbar);
                    },
                    type: ContextMenuButtonType.cut,
                  ),
                  ContextMenuButtonItem(
                    onPressed: () {
                      editableTextState
                          .copySelection(SelectionChangedCause.toolbar);
                    },
                    type: ContextMenuButtonType.copy,
                  ),
                ],
              );
            },
          ),
          Container(
            height: 40,
            color: Colors.green,
            child: const Text(
              'Use this package if you need more customization when notifying your user. For Android developers, it is made to substitute toasts and snackbars. IOS developers, I don'
              't know what you use there, but you will like it',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  overflow: TextOverflow.clip),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 40,
            color: Colors.green,
            child: const Text(
              'Use this package if you need more customization when notifying your user. For Android developers, it is made to substitute toasts and snackbars. IOS developers, I don'
              't know what you use there, but you will like it',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 40,
            color: Colors.green,
            child: const Text(
              'Use this package if you need more customization when notifying your user. For Android developers, it is made to substitute toasts and snackbars. IOS developers, I don'
              't know what you use there, but you will like it',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  overflow: TextOverflow.fade),
              softWrap: false,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 40,
            color: Colors.green,
            child: const Text(
              'Use this package if you need more customization when notifying your user. For Android developers, it is made to substitute toasts and snackbars. IOS developers, I don'
              't know what you use there, but you will like it',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  overflow: TextOverflow.visible),
              softWrap: false,
            ),
          ),
        ]);
  }

  int indx = 0;
  CarouselSlider imageSlider1() {
    return CarouselSlider(
      options: CarouselOptions(
        pauseAutoPlayInFiniteScroll: false,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        onPageChanged: (index, _) {
          setState(() {
            indx = index;
          });
        },
        scrollDirection: Axis.horizontal,
      ),
      items: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Colors.blue),
                child: Image.asset(i));
          },
        );
      }).toList(),
    );
  }
}
