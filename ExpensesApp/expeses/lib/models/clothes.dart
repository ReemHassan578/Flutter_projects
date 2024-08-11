import 'package:flutter/material.dart';

import 'expense.dart';

class Clothes extends Expense{
  static double total=0;
  static const String cat ='clothes';
  static const IconData ic=Icons.videogame_asset_off_sharp;
  final String id;
  Clothes( { required super.product, required super.amount, required super.purchasedate}): id = ob.v1()
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