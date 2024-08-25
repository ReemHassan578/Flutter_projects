import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/screens/meals_screen.dart';

import '../models/category.dart';
import '../models/meal.dart';
import '../providers/filters_provider.dart';

class CategoryGridItem extends ConsumerWidget {
  final Category cat;

  const CategoryGridItem(this.cat, {super.key});

  @override
  Widget build(BuildContext context, ref) {
    List<Meal> filteredMeals = ref.watch(selectedMealsProvider);
    return InkWell(
      onTap: () {
        List<Meal> lisF = filteredMeals.where(
          (element) {
            return element.categories.contains(cat.id);
          },
        ).toList();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) {
            return MealsScreen(lisF, title: cat.name);
          },
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(colors: [
              cat.color,
              cat.color.withOpacity(0.9),
              cat.color.withOpacity(0.5),
            ], begin: Alignment.topLeft)),
        child: Text(
          cat.name,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
      ),
    );
  }
}
