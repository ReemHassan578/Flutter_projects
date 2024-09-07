import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopapp/data/categories.dart';
import 'package:shopapp/models/grocery_item.dart';

import '../models/category.dart';
import '../widgets/grocery_list.dart';
import 'new_item_screen.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<GroceryItem> list = [];
  bool empty = true;
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  @override
  Widget build(BuildContext context) {
    empty = list.isEmpty;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Greocery',
            style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
              onPressed: error != null ?null:() {
                Navigator.of(context).push<GroceryItem>(
                  MaterialPageRoute(
                    builder: (context) {
                      return const NewItemScreen();
                    },
                  ),
                ).then(
                  (value) async {
                    if (value == null) {
                      return;
                    } else {
                      setState(() {
                        list.add(value);
                      });
                      // http.Response dt = await getItems();
                      // log(dt.body);
                    }
                  },
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              )),
        ],
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (empty
              ? Center(
                  child: Text(error == null ? 'no items ' : error!),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GroceryList(
                      list: list,
                      rebuildP: (GroceryItem value) async {
                        var indx = list.indexOf(value);
                        setState(() {
                          list.remove(value);
                        });
                     try{   Uri url = Uri.parse(
                            'https://test-ddaff-default-rtdb.firebaseio.com/shop/${value.id}.json');
                        http.Response res = await http.delete(
                          url,
                          headers: {'Content-Type': 'application/json'},
                        );
                        if (res.statusCode >= 400) {
                          setState(() {
                            list.add(value);
                            list.insert(indx, value);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Item not deleted , try again later')));
                          });
                        } }catch(_){  setState(() {
                            list.add(value);
                            list.insert(indx, value);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Item not deleted , try again later')));
                          });

                        }
                      }),
                )),
    );
  }

  void loadItems() async {
    try{
      Uri url =
        Uri.parse('https://test-ddaff-default-rtdb.firebaseio.com/shop.json');
    http.Response res =
        await http.get(url, headers: {'Content-Type': 'application/json'});
        log(res.statusCode.toString());
    if (res.statusCode == 200) {
      final Map<String, dynamic>? data = json.decode(res.body);
      if (data == null) {
        setState(() {
          error = null;
          loading = false;
        });
      } else {
        List<GroceryItem> load = [];

        for (final i in data.entries) {
          MapEntry<Categories, Category> loadcat =
              categories.entries.firstWhere(
            (element) {
              return element.value.name == i.value['category'];
            },
          );

          load.add(GroceryItem(
              id: i.key,
              name: i.value['name'],
              quantity: i.value['quantity'],
              category: loadcat.value));
        }
        setState(() {
          list = load;
          loading = false;
        });
      }
    } else { 
      
      setState(() {
        error = 'Error, Try Again Later';
        loading = false;
      }); 
    
      }
        } catch(e){
           setState(() {
        error = 'Error, Try Again Later';
        loading = false;
      }); 
        }
  }
}
