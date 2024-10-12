import 'package:flutter/material.dart';

class PlusMinusContainer extends StatelessWidget {
  final String text;
  final int value;
  final Function() add;
  final Function() subtract;

  const PlusMinusContainer(
      {super.key,
      required this.text,
      required this.value,
      required this.add,
      required this.subtract});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.secondary,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: Text(
                '$value',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filled(
                      alignment: Alignment.center,
                      onPressed: subtract,
                      icon: const Icon(
                        Icons.minimize_rounded,
                      )),
                  SizedBox(width: 5),
                  IconButton.filled(
                      onPressed: add, icon: const Icon(Icons.add)),
                ],
              ),
            )
          ],
        ));
  }
}
