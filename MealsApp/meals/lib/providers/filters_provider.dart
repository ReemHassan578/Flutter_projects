import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';
import 'meals_provider.dart';

enum Filter { gluten, lactose, vegan, vegetarian }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.gluten: false,
          Filter.lactose: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });

  void setFilter(Filter filter, bool onOff) {
    state = {...state, filter: onOff};
  }

  void filters(Map<Filter, bool> filter) {
    state = filter;
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) {
    return FilterNotifier();
  },
);

final selectedMealsProvider = Provider(
  (ref) {
    List<Meal> dummyMeals = ref.read(mealsProvider);
    final Map<Filter, bool> filter = ref.watch(filterProvider);
    List<Meal> lisF = dummyMeals.where((element) {
      if (filter[Filter.gluten]! && !element.isGlutenFree) {
        return false;
      }
      if (filter[Filter.lactose]! && !element.isLactoseFree) {
        return false;
      }
      if (filter[Filter.vegan]! && !element.isVegan) {
        return false;
      }
      if (filter[Filter.vegetarian]! && !element.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
    return lisF;
  },
);
