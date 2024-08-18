import 'package:flutter/material.dart';
import 'package:meals/screens/meals_screen.dart';

import '../data/dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';

class CategoryGridItem extends StatelessWidget {
  final Category cat;
  const CategoryGridItem(this.cat,this.toggleFav, {super.key});
    final Function(Meal item) toggleFav;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        List<Meal> lis= dummyMeals.where((element) {
          return element.categories.contains(cat.id);
         }).toList();
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return MealsScreen(lis,toggleFav,title:cat.name);
        },));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin:const EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius:BorderRadius.circular(8) ,
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
