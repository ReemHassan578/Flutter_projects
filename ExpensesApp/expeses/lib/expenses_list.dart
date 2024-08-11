
import 'package:flutter/material.dart';

import 'expenses_item.dart';
import 'models/expense.dart';

class ExpensesList extends StatelessWidget {
  
  final void Function(Expense ex) removeExpense;
  final List<Expense> e;
  const ExpensesList(this.e,this.removeExpense,{super.key, });

 


  @override
  Widget build(BuildContext context) {
    return ListView.builder( 
      itemBuilder: (context, index) {
        return  ExpensesItem(e[index],removeExpense);
      },

      itemCount: e.length,  
    );
  }
}
