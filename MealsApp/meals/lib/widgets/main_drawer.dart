import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
            ])),
            padding: const EdgeInsets.all(19),
            child: Row(
              children: [
                Icon(Icons.fastfood,
                    color: Theme.of(context).colorScheme.primary, size: 40),
                const SizedBox(width: 19),
                Text(
                  'Cooking ...',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                )
              ],
            ),
          ),
          Text('Meals ...',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.primary,),)

        ],
      ),
    );
  }
}
