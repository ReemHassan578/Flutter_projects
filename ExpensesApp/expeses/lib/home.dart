import 'package:flutter/material.dart';

import 'expenses_list.dart';
import 'newexpense.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
                    return   NewExpense();
                       
                  });
            },
          ),
        ],
        title: const Text("Home Page"),
      ),
      body: const Center(
        child: Column(
          children: [
            Expanded(
              child: ExpensesList(),
            ),
          ],
        ),
      ),
    );
  }
}

