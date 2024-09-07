import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopapp/data/categories.dart';
import 'package:shopapp/models/grocery_item.dart';
import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../widgets/text_form.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late String newV;

  late int quantity;

  late Category selCat;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextForm(
                label: 'Name',
                valid: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.trim().length <= 1) {
                    return 'enter valid value';
                  } else {
                    return null;
                  }
                },
                save: (newvalue) {
                  newV = newvalue!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextForm(
                      label: 'Quantity',
                      valid: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'enter valid value';
                        } else {
                          int? quan = int.tryParse(value);
                          return quan == null || quan <= 0
                              ? 'enter valid value'
                              : null;
                        }
                      },
                      save: (newvalue) {
                        quantity = int.tryParse(newvalue!)!;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField(
                      validator: (value) {
                        if (value == null) {
                          return 'choose category';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) {
                        selCat = newValue!;
                      },
                      onChanged: (value) {},
                      items: [
                        for (final i in categories.values)
                          DropdownMenuItem(
                            value: i,
                            child: Row(
                              children: [
                                Container(
                                  color: i.color,
                                  width: 16,
                                  height: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(i.name),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: loading
                        ? null
                        : () {
                            _formkey.currentState!.reset();
                          },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: loading ? null : saveItem,
                    child: loading
                        ? const SizedBox(
                            height: 12,
                            width: 12,
                            child: CircularProgressIndicator())
                        : const Text('Add Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> postItem() async {
    Uri url =
        Uri.parse('https://test-ddaff-default-rtdb.firebaseio.com/shop.json');
    http.Response res = await http.post(
      url,
      body: json.encode({
        'category': selCat.name,
        'name': newV,
        'quantity': quantity,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    return res;
  }

  saveItem() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      setState(() {
        loading = true;
      });
      postItem().then(
        (value) {
          if (value.statusCode >= 400) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Item not added , try again ')));
          } else {
            Map<String, dynamic> obj = json.decode(value.body);

            Navigator.of(context).pop(GroceryItem(
              category: selCat,
              name: newV,
              quantity: quantity,
              id: obj.entries.first.value,
            ));
          }
        },
      ).catchError((_) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Item not added , try again ')));
      });
    }
  }
}
