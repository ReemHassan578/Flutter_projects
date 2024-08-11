import 'dart:developer';

import 'package:flutter/material.dart';


import 'chart.dart';
import 'expenses_list.dart';
import 'models/expense.dart';
 import '../models/clothes.dart';
import '../models/food.dart';
import '../models/travel.dart';
import 'newexpense.dart';

class Home extends StatefulWidget {
   const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Expense> e=[
Food( product: 'Chips', amount: 15.0, purchasedate: DateTime.now()),
Clothes( product: 'Shirt', amount: 270.0, purchasedate: DateTime(2023)),
Travel( product: 'Qatar', amount: 5000.0, purchasedate: DateTime(2019,9,30)),
];

 void addExpense(Expense ex){
setState(() {
   e.add(ex);
});
 
 
}

 void removeExpense(Expense ex){
setState(() {
  e.remove(ex);
});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () { 
              showModalBottomSheet(isDismissible:false ,
                  context: context,
                  builder: (cntx) {
                    return   NewExpense(addExpense: addExpense );
                       
                  });
            },
          ),
        ],
        title: const Center(child:Text("Expense Tracker ")),
      ),
      body:  Center(
        child: Column(
          children: [
            Chart()
            ,
            Expanded(
              child: ExpensesList(e,removeExpense),
            ),
          ],
        ),
      ),
    );
  }
  
}

