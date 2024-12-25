import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/colors.dart';

class DefaultElevatedButton extends StatelessWidget {
  final String text;
  final double width;
  final void Function() onPress;
  const DefaultElevatedButton(
      {super.key,
      required this.text,
      required this.onPress,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      onTap: onPress,
      child: Container(
        height: 40.h,
        color: defaultColor,
        width: width,
        child: Center(
          child: Text(
            text.toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
