import 'package:flutter/material.dart';

import 'models/expense.dart';

class ExpensesItem extends StatelessWidget {
  
  final void Function(Expense ex) removeExpense;
  final Expense ex;
  const ExpensesItem(
    this.ex,this.removeExpense, {
    super.key,  
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.7),
        ),
      )
      ,onDismissed: (direction) {
      removeExpense(ex);
    },
      key: ValueKey(ex),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ex.product,style: Theme.of(context).textTheme.titleLarge,),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(child: Text('\$${ex.amount}')),
                    //const Spacer(),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: Icon(ex.icon)),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(child: Text(ex.changeFormat())),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
