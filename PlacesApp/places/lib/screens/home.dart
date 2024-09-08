import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/models/place.dart';

import '../providers/list_provider.dart';
import '../widgets/places_list.dart';
import 'add_place.dart';
import 'place_details.dart';


class Home extends ConsumerWidget {
  const Home({super.key}); 
 
 clickPlace(BuildContext cntx,Place place){
 Navigator.of(cntx).push(MaterialPageRoute(builder: (context) {
              return  PlaceDetails(place:place);
            },)); }

  @override
  Widget build(BuildContext context,ref) {
    final List<Place> list=ref.watch(listProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const AddPlace();
            },));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: PlacesList(list,clickPlace),
    );
  }
}
