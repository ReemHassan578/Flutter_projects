import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [],
            ),
            Container(),
            Row(
              children: [],
            ),
            Container(
              child: TextButton(onPressed: () {}, child: Text('Get Started')),
            ),
          ],
        ),
      ),
    );
  }
}
