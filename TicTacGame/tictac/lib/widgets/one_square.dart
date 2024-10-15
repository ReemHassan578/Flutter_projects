import 'package:flutter/material.dart';

class OneSquare extends StatefulWidget {
  final String turn;
  final bool gameEnd;
  final bool restart;
  final Function() play;
  const OneSquare(
      {super.key,
      required this.play,
      required this.turn,
      required this.gameEnd,
      required this.restart});

  @override
  State<OneSquare> createState() => _OneSquareState();
}

class _OneSquareState extends State<OneSquare> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    if (widget.restart) {
      setState(() {
        pressed = false;
      });
    }
    if (widget.turn == 'O' || widget.turn == 'X') {
      setState(() {
        pressed = true;
      });
    }
    return InkWell(
      onTap: (pressed || widget.gameEnd) && (!widget.restart)
          ? null
          : () {
              setState(() {
                pressed = true;
              });
              widget.play();
            },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration:
            BoxDecoration(color: Colors.blue[900], border: Border.all()),
        child: Center(
            child: Text(
          widget.turn == 'O' ? 'O' : (widget.turn == 'X' ? 'X' : ''),
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: widget.turn == 'O' ? Colors.pink : Colors.white),
        )),
      ),
    );
  }
}
