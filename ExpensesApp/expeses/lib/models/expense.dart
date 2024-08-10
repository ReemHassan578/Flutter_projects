
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const ob = Uuid();
final date=DateFormat.yMEd();


enum Category { food, clothes, travel }
const categoryIcons={
  Category.food : Icons.lunch_dining,
  Category.travel: Icons.flight_land_outlined,
  Category.clothes:Icons.videogame_asset_off_sharp,
};

class Expense {
  final String product;
  final String id;
  final double amount;
  //int quantity;
  Category category;
  final DateTime purchasedate;

  String changeFormat(){
    return date.format(purchasedate); 
  }
  Expense(
      {required this.category,
      required this.product,
      required this.amount,
      required this.purchasedate})
      : id = ob.v1();
}
