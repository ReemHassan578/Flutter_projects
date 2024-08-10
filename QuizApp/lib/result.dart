import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final void Function() restart;
  const Result(this.score, this.restart, {super.key});
  final int score;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Your Result is  ',
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '$score',
              style: TextStyle(color: Colors.pink[200], fontSize: 40),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[200],
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                restart();
              },
              child: const Text("Restart Quiz"),
            ),
          ]),
    );
  }
}
