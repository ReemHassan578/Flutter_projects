import 'package:flutter/material.dart';

import 'expense.dart';

class Food extends Expense{
  static const String cat ='food';
  static double total=0;
  static const IconData ic=Icons.lunch_dining;
    final String id;
  Food({ required super.product, required super.amount, required super.purchasedate}): id=ob.v1(){
    total+=amount;
  }

 @override
  IconData get icon{
return ic;
 }
  
 @override
  String get category{
return cat;
 }
}