import 'package:expeses/models/clothes.dart';
import 'package:expeses/models/expense.dart';
import 'package:expeses/models/food.dart';
import 'package:expeses/models/travel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense ex) addExpense;

  const NewExpense({
    required this.addExpense,
    super.key,
  });

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  DateTime? date;
  final title = TextEditingController();
  final amount = TextEditingController();
  final obDF = DateFormat.yMd();
  Category? category;
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
      child: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
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
              LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: amount,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: '\$',
                            hintText: 'Add Expense Amount',
                            label: Text('Expense Amount',
                                style: TextStyle(
                                    fontSize: constraints.maxWidth * 0.035)),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                              date == null ? 'Choose Date' : obDF.format(date!),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: constraints.maxWidth * 0.035)),
                          IconButton(
                              icon: const Icon(Icons.calendar_month_outlined),
                              onPressed: () {
                                final now = DateTime.now();
                                final iDate = DateTime(now.year - 1);
                                final lDate = DateTime(now.year + 5);
                                showDatePicker(
                                        context: context,
                                        initialDate: now,
                                        firstDate: iDate,
                                        lastDate: lDate)
                                    .then(
                                  (value) {
                                    setState(() {
                                      date = value;
                                    });
                                  },
                                );
                              }),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              LayoutBuilder(builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DropdownButton(
                          value: category,
                          items: [
                            ...Category.values.map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              constraints.maxWidth * 0.035)),
                                ))
                          ],
                          onChanged: (value) {
                            setState(() {
                              category = value;
                            });
                          }),
                    ),
//Expanded(child: SizedBox(width:constraints.maxWidth*0.1)),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: constraints.maxWidth * 0.035),
                      ),
                    )),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            valid(context);
                          },
                          child: Text(
                            'Save Expense',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: constraints.maxWidth * 0.035),
                          )),
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  void valid(BuildContext cntx) {
    final double? enteredAmount = double.tryParse(amount.text);
    String mError = '';
    if (title.text.trim().isEmpty) {
      mError += 'enter title\n';
    }
    if (date == null) {
      mError += 'choose date\n';
    }
    if (category == null) {
      mError += 'choose category\n';
    }
    if (amount.text.trim().isEmpty) {
      mError += 'enter amount\n';
    } else if (enteredAmount == null || enteredAmount <= 0) {
      mError += 'enter proper amount\n';
    }
    if (mError != '') {
      showDialog(
          barrierDismissible: false,
          context: cntx,
          builder: (context) {
            return AlertDialog(
              title: Text(mError),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            );
          });
    } else {
      switch (category!) {
        case Category.food:
          widget.addExpense(Food(
              product: title.text,
              amount: enteredAmount!,
              purchasedate: date!));
        case Category.clothes:
          widget.addExpense(Clothes(
              product: title.text,
              amount: enteredAmount!,
              purchasedate: date!));
        case Category.travel:
          widget.addExpense(Travel(
              product: title.text,
              amount: enteredAmount!,
              purchasedate: date!));
      }
      Navigator.of(cntx).pop();
    }
  }
}
