import 'package:flutter/material.dart';

class GenderContainer extends StatelessWidget {
  final IconData icon;
  final String gender;
  final String type;
  final Function() onPress;
  const GenderContainer(
      {super.key,
      required this.icon,
      required this.type,
      required this.onPress,
      required this.gender});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(12),
      color: gender == type ? theme.primary : theme.secondary,
      child: InkWell(
        onTap: onPress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
            ),
            Text(
              type,
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
      ),
    );
  }
}
