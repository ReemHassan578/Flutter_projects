import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/screens/meals_screen.dart';

import '../models/meal.dart';
import '../providers/favorites_provider.dart';
import '../providers/navigationbar_provider.dart';
import '../widgets/main_drawer.dart';
import 'filters_screen.dart';
import 'home.dart';

// const Map<Filter,bool> kFilters={
// Filter.gluten:false,
// Filter.lactose:false,
//           Filter.vegan:false,
//           Filter.vegetarian:false,

//   };

class TabsScreen extends ConsumerWidget {
  const TabsScreen({super.key});


  @override
  Widget build(BuildContext context,ref) {
    final List<Meal> fav = ref.watch(favoriteMealsProvider);
    final int curScreen = ref.watch(navigationBarProvider);
    return Scaffold(
      drawer: MainDrawer((String id) {
        if (id == 'filters') {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const FiltersScreen('Filters');
              },
            ),
          );
        } else {
          Navigator.of(context).pop();
          ref.read(navigationBarProvider.notifier).switchBar('Category');
        }
      }),
      appBar: AppBar(
        title: Text(curScreen == 0 ? 'Choose your Category' : 'Favorites'),
      ),
      body: curScreen == 0 ? const Home() : MealsScreen(fav),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: curScreen,
        onTap: (value) {
          value == 0
              ? ref.read(navigationBarProvider.notifier).switchBar('Category')
              : ref.read(navigationBarProvider.notifier).switchBar('Favorites');

          // curTitle = value == 0 ? 'Categories' : 'Favorites';
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
