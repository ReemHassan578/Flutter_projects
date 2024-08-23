
import 'package:flutter/material.dart';
import 'package:meals/screens/meals_screen.dart';

import '../data/dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';
import '../screens/filters_screen.dart';

class CategoryGridItem extends StatelessWidget {
  final Category cat;
  final Map<Filter, bool>? filter;
  const CategoryGridItem(this.cat, this.toggleFav, {this.filter, super.key});
  final Function(Meal item) toggleFav;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        List<Meal> lis = dummyMeals.where((element) {
          return element.categories.contains(cat.id);
        }).toList();
        List<Meal> lisF = filter == null
            ? lis
            : lis.where((element) {
                  if(filter![Filter.gluten]! &&  !element.isGlutenFree) {return false;}
                   if (filter![Filter.lactose]! && !element.isLactoseFree ){return false;}
                  if(filter![Filter.vegan]! && !element.isVegan ){return false;}
                  if (filter![Filter.vegetarian]! && !element.isVegetarian){return false;}
                   return true;
                    
              }).toList();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) {
            return MealsScreen(lisF, toggleFav, title: cat.name);
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
