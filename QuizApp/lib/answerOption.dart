import 'package:flutter/material.dart';

import 'data/questions.dart';

class Option extends StatefulWidget {
  final String option;
  final int qnumber;
  final void Function(String, String) stan;
  const Option(this.option, this.qnumber, this.stan, {super.key});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  int answer = -1;
  String choice = '';
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: (!questions[widget.qnumber].chooseOption)
                ? Colors.pink[200]
                : ((answer == 1 && answer != 0)
                    ? Colors.lightGreen
                    : (answer == -2 && choice == ''
                        ? Colors.pink[200]
                        : (answer == 0
                            ? Colors.red
                            : (answer == -2 && choice == widget.option
                                ? color
                                : Colors.pink[200])))),
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            setState(() {
              answer =
                  widget.option == questions[widget.qnumber].answers[0] ? 1 : 0;
              if (!questions[widget.qnumber].chooseOption) {
                choice = widget.option;
                color = answer == 1 ? Colors.lightGreen : Colors.red;
                questions[widget.qnumber].chooseanswer();
                widget.stan(questions[widget.qnumber].question, widget.option);
              } else {
                answer = -2;
              }
            });
          },
          child: Text(
            widget.option,
          ),
        ),
      ),
    );
  }
}
