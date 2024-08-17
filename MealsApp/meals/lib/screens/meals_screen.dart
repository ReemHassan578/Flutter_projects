import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';


class MealsScreen extends StatelessWidget {
 
  final String title;
  final List<Meal> list;
   const MealsScreen( this.title,  this.list,{super.key});

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text(title ),
      ),
      body:ListView.builder(itemBuilder: (context, index) {
         
        return  MealItem(list[index]);
       
      },itemCount: list.length,
      ),
    );
  }
}