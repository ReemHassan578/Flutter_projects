import 'package:flutter/material.dart';

import 'expense.dart';

class Travel extends Expense{
  static double total=0;
  static const String cat ='travel';
  static const IconData ic=Icons.flight_land_outlined;
    final String id;
  Travel({ required super.product, required super.amount, required super.purchasedate}): id=ob.v1()
  {
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