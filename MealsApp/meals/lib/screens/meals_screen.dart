import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

import 'meal_details_screen.dart';




class MealsScreen extends StatelessWidget {
 
  final String? title;
  final List<Meal> list;
    final Function(Meal item) togglefav;

   const MealsScreen(   this.list,this.togglefav, {this.title,super.key});




  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: title==null ?Container():Text(title! ),
      ),
      body:ListView.builder(itemBuilder: (context, index) {
         
        return  MealItem(list[index],(Meal item){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MealDetailsScreen(item,togglefav);
        },));
        });
       
      },itemCount: list.length,
      ),
    );
  }
}