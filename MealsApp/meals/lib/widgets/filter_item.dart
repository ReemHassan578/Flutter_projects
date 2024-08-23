import 'package:flutter/material.dart';

class FilterItem extends StatefulWidget {
  final String title;
  final String subTitle;
  final bool pressed;
  final Function(bool) onpressed;

 const  FilterItem(this.pressed, 
   this.onpressed,
      {super.key, required this.title, required this.subTitle});

  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: widget.pressed,
      onChanged: (value) {
        widget.onpressed(value);
    
      },
      title: Text(widget.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              )),
      subtitle: Text(widget.subTitle,style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              )),
    );
  }
}
