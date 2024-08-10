import 'package:flutter/material.dart';

import 'data/expenses.dart';
import 'models/expense.dart';

class ExpensesItem extends StatelessWidget {
  final int index;
  const ExpensesItem(
    this.index, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(e[index].product),
              const SizedBox(height: 5,),
             
              Row( 
                children: [
                  Expanded(child:Text('\$${e[index].amount}')),
                  //const Spacer(),
                  Expanded(child: Row( mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     
                    Icon(categoryIcons[e[index].category]),
                    const SizedBox(width: 5,),
                      Text(e[index].changeFormat() ),
                    ],
                  ),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
