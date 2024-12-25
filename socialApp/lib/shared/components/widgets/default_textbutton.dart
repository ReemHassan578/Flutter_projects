import 'package:flutter/material.dart';

class DefaultTextButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  const DefaultTextButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
