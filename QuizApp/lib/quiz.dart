import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/questions.dart';
import 'package:flutter_application_1/result.dart';
import 'data/questions.dart';
import 'home.dart';
import 'question.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  late Widget screen;
  final Map<String, String> userans = {};

  void storeAnswer(String q, String a) {
    userans[q] = a;
  }

  void finish() {
    setState(() {
      screen = Result(getscore(), restart);
    });
  }

  void restart() {
    userans.clear();
    setState(() {
      screen = Home(switchScreen);
    });
  }

  int getscore() {
    int score = 0;
    for (Questions element in questions) {
      if (userans.containsKey(element.question)) {
        if (userans[element.question] == element.answers[0]) {
          score++;
        }
      }
    }

    return score;
  }

  void switchScreen() {
    setState(() {
      screen = Question(storeAnswer, getscore, finish);
    });
  }

  @override
  void initState() {
    super.initState();
    screen = Home(switchScreen);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.pink[200]!],
            ),
          ),
          child: screen,
        ),
      ),
    );
  }
}
