import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool pressed;
  final Function(bool) onpressed;

  const FilterItem(this.pressed, this.onpressed,
      {super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: pressed,
      onChanged: (value) {
        onpressed(value);
      },
      title: Text(title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              )),
      subtitle: Text(subTitle,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              )),
    );
  }
}
