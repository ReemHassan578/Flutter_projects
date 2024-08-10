import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/questions.dart';
import 'answerOption.dart';
import 'data/questions.dart' as q;

class Question extends StatefulWidget {
  final void Function(String,String) stan;
  final int Function() getscore;
  final void Function() finish;
  const Question(this.stan, this.getscore, this.finish, {super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  Questions cur = q.questions[0];
  int num = 0;
  Color? buttoncolor;
  bool max = false;
  String pressed = '';
  List<List<String>> shuf = [];

  @override
  void initState() {
    super.initState();
    for (Questions i in q.questions) {
      shuf.add(i.shuffledList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            cur.question,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          ...shuf[num].map((e) {
            return Option(e, num, widget.stan);
          }),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.pink[200],
                ),
                onPressed: () {
                  setState(() {
                    q.questions[num].chooseOption = false;
                    num++;
                    if (num == q.questions.length) {
                      widget.finish();
                    } else {
                      cur = q.questions[num];
                    }
                  });
                },
                child: const Text(" Next"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
