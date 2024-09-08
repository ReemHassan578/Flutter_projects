import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/models/place.dart';

class ListNotifier extends StateNotifier<List<Place>> {
  ListNotifier() : super([]);

  void addPlace(Place place) {
    state = [place, ...state];
  }
}

final  listProvider =
    StateNotifierProvider<ListNotifier, List<Place>>(
  (ref) {
    return ListNotifier();
  },
);
