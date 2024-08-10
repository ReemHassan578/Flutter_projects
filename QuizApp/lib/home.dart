import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final void Function() switchScreen;

  const Home(this.switchScreen, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/quiz-logo.png', width: 300),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Learn Flutter ',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[200],
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              switchScreen();
            },
            label: Text(
              'Start Quiz',
              style: TextStyle(color: Colors.amber[50]),
            ),
            icon: const Icon(Icons.arrow_circle_right),
          ),
        ],
      ),
    );
  }
}
