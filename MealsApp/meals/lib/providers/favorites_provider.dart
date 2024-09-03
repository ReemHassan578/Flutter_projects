import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleFav(Meal item) {
    if (state.contains(item)) {
      state = state.where(
        (element) {
          return element.id != item.id;
        },
      ).toList();
      return false;
      //   state.remove(item);
    } else {
      state = [...state, item];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  (ref) {
    return FavoriteMealsNotifier();
  },
);
