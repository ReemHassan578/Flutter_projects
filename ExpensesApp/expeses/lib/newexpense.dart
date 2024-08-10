import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
  });

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  DateTime? date;
  final title = TextEditingController();
  final amount = TextEditingController();
  final obDF=DateFormat.yMd();
  @override
  void dispose() {
    super.dispose();
    title.dispose();
    amount.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: title,
            maxLength: 50,
            decoration: const InputDecoration(
              hintText: 'Add Expense Name',
              label: Text("Expense Name"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    hintText: 'Add Expense Amount',
                    label: Text("Expense Amount"),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                   Text(date==null ? 'Choose Date' : obDF.format(date!)),
                  IconButton(
                      icon: const Icon(Icons.calendar_month_outlined),
                      onPressed: () {
                        final now= DateTime.now();
                        final iDate = DateTime(now.year-1);
                        final  lDate = DateTime(now.year+5); 
                        showDatePicker(

                            context: context,
                            initialDate: now,
                            firstDate: iDate,
                            lastDate: lDate).then((value) {
                              setState(() {
                                date=value;
                              });
                            },);
                      }),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    log(amount.text);
                    log(title.text);
                  },
                  child: const Text('Save Expense')),
            ],
          )
        ],
      ),
    );
  }
}
