import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationBarNotifier extends StateNotifier<int> {
  NavigationBarNotifier() : super(0);

  void switchBar(String id) {
    if (id == 'Favorites') {
      state = 1;
    } else {
      state = 0;
    }
  }
}

final navigationBarProvider = StateNotifierProvider<NavigationBarNotifier, int>(
  (ref) {
    return NavigationBarNotifier();
  },
);
