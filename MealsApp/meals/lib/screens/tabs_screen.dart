import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meals/screens/meals_screen.dart';

import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import 'filters_screen.dart';
import 'home.dart';

const Map<Filter,bool> kFilters={
Filter.gluten:false,
Filter.lactose:false,
          Filter.vegan:false,
          Filter.vegetarian:false,

  };

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int curScreen = 0;
  String curTitle = 'Choose your Category';
  final List<Meal> fav = [];
  Map<Filter,bool> filter=kFilters;

  void showinfo(String con) {
    ScaffoldMessenger.of(context).clearSnackBars();

    SnackBar infobar = SnackBar(
      content: Text(con),
    );
    ScaffoldMessenger.of(context).showSnackBar(infobar);
  }

  void toggleFav(Meal item) {
    if (fav.contains(item)) {
      setState(() {
        fav.remove(item);
      });
      showinfo('${item.name} is removed from favorites');
    } else {
      setState(() {
        fav.add(item);
      });
      showinfo('${item.name} is added to favorites');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer((String id) {
        if (id == 'filters') {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return  FiltersScreen('Filters',filter:filter);
              },
            ),
          ).then(( value) {
            setState(() {
              filter=value?? kFilters ;
            }); 
            log(value.toString()
            );
          },);
        } else {
          Navigator.of(context).pop();
         setState(() {
           curScreen=0;
           curTitle='Choose your Category';
         });
        }
      }),
      appBar: AppBar(
        title: Text(curTitle),
      ),
      body: curScreen == 0 ? Home(toggleFav,filter: filter,) : MealsScreen(fav, toggleFav),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: curScreen,
        onTap: (value) {
          setState(() {
            curScreen = value;
            curTitle = value == 0 ? 'Categories' : 'Favorites';
          });
        },
        selectedItemColor:
            Theme.of(context).colorScheme.primaryContainer.withOpacity(1),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
