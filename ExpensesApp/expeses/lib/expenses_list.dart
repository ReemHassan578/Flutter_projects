
import 'package:flutter/material.dart';

import 'data/expenses.dart';
import 'expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder( 
      itemBuilder: (context, index) {
        return  ExpensesItem(index);
      },

      itemCount: e.length,  
    );
  }
}
