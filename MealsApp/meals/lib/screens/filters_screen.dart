import 'package:flutter/material.dart';

import '../widgets/filter_item.dart';

enum Filter { gluten, lactose, vegan, vegetarian }

class FiltersScreen extends StatefulWidget {
  final String title;
  final Map<Filter,bool> filter;
  const FiltersScreen(this.title, {required this.filter,super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late bool glutenFree;
     late   bool lactoseFree;
      late       bool vegan;
       late      bool vegetarian;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    glutenFree=widget.filter[Filter.gluten]!;
    lactoseFree=widget.filter[Filter.lactose]!;
    vegan=widget.filter[Filter.vegan]!;
    vegetarian=widget.filter[Filter.vegetarian]!;

    
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          } else {
            Navigator.of(context).pop({
              Filter.gluten: glutenFree,
              Filter.lactose: lactoseFree,
              Filter.vegan: vegan,
              Filter.vegetarian: vegetarian,
            });
          }
        },
        child: Column(
          children: [
            FilterItem(
              glutenFree,
              (bool value) {
                setState(() {
                  glutenFree = value;
                });
              },
              subTitle: 'Only include gluten-free meals.',
              title: 'Gluten-free',
            ),
            FilterItem(
              lactoseFree,
              (bool value) {
                setState(() {
                  lactoseFree = value;
                });
              },
              subTitle: 'Only include lactose-free meals.',
              title: 'Lactose-free',
            ),
            FilterItem(
              vegan,
              (bool value) {
                setState(() {
                  vegan = value;
                });
              },
              subTitle: 'Only include vegan meals.',
              title: 'Vegan',
            ),
            FilterItem(
              vegetarian,
              (bool value) {
                setState(() {
                  vegetarian = value;
                });
              },
              subTitle: 'Only include vegetarian meals.',
              title: 'Vegetarian',
            ),
          ],
        ),
      ),
    );
  }
}
