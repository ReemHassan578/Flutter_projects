import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/background_logo.dart';
import '../widgets/doc_logo_and_name.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.center,
            children: [
              
              BackgroundLogo(),
              DocLogoAndName(),
            ],
          ),
        ),
      ),
    );
  }
}
