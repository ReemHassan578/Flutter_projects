import 'package:flutter/material.dart';
import 'package:meals/screens/meals_screen.dart';

import '../data/dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';

class CategoryGridItem extends StatelessWidget {
  final Category cat;
  const CategoryGridItem(this.cat, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        List<Meal> lis= dummyMeals.where((element) {
          return element.categories.contains(cat.id);
         }).toList();
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return MealsScreen(cat.name,lis);
        },));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          cat.color,
         cat.color.withOpacity(0.9), cat.color.withOpacity(0.5),
          
        ],
        begin: Alignment.topLeft)),
        child: Text(cat.name,style: Theme.of(context).textTheme.titleLarge!.copyWith(color:Theme.of(context).colorScheme.onPrimaryContainer ),),
      ),
    );
  }
}
