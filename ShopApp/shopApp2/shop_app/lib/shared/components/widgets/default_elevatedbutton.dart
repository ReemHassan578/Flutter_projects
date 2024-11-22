import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class DefaultElevatedButton extends StatelessWidget {
  final String text;
  final void Function() onPress;
  const DefaultElevatedButton(
      {super.key, required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      onTap: onPress,
      child: Container(
        height: 40,
        color: defaultColor,
        width: double.infinity,
        child: Center(
          child: Text(
            text.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
