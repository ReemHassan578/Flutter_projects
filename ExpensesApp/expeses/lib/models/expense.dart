
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const ob = Uuid();
final date=DateFormat.yMEd();


enum Category { food, clothes, travel }
//const categoryIcons={
 // Category.food : Icons.lunch_dining,
 // Category.travel: Icons.flight_land_outlined,
//  Category.clothes:Icons.videogame_asset_off_sharp,
//};

abstract class Expense {
  final String product;
  final double amount;
  //int quantity;
  final DateTime purchasedate;
IconData get icon;
String get category;

  String changeFormat(){
    return date.format(purchasedate); 
  }
  Expense(
      {
      required this.product,
      required this.amount,
      required this.purchasedate})
      ;
}
