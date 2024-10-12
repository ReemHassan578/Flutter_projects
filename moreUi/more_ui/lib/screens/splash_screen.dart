import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:more_ui/main.dart';

import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        'lib/assets/s1.jpg',
      ),
      logoWidth: 100,
      backgroundColor: Colors.blueAccent,
      title: const Text('This is Splash Screen'),
      loadingText: const Text('loading'),
      showLoader: true,
      navigator: const HomeScreen(),
      durationInSeconds: 5,
    );
  }
}
