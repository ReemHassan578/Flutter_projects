import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/models/place.dart';

import '../providers/list_provider.dart';
import '../widgets/places_list.dart';
import 'add_place.dart';
import 'place_details.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late bool isLoading;
  Future<void>? loadedPlaces;
  clickPlace(BuildContext cntx, Place place) {
    Navigator.of(cntx).push(MaterialPageRoute(
      builder: (context) {
        return PlaceDetails(place: place);
      },
    ));
  }

  @override
  void initState() {
    super.initState();
    loadedPlaces = ref.read(listProvider.notifier).loadPlace();
    // loadData();
  }

  /*Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    await ref.read(listProvider.notifier).loadPlace();
    setState(() {
      isLoading = false;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final List<Place> list = ref.watch(listProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const AddPlace();
                  },
                ));
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: FutureBuilder(
          future: loadedPlaces,
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : PlacesList(list, clickPlace);
          },
        )

        //isLoading
        //  ? const Center(child: CircularProgressIndicator())
        //: PlacesList(list, clickPlace),
        );
  }
}
