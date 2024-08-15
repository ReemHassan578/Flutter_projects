import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double fill;
  const ChartBar(this.fill, {super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      
      heightFactor: fill,
      child: Container(

        

          color: Theme.of(context).colorScheme.primaryContainer,
       
      ),
    );
  }
}
