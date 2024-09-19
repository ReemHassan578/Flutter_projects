import 'package:flutter/material.dart';

import '../models/place.dart';

class PlacesList extends StatelessWidget {
  final List<Place> list;
  final void Function(BuildContext cntx, Place nameP) clickPlace;
  const PlacesList(this.list, this.clickPlace, {super.key});

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return const Center(
        child: Text('No places added yet '),
      );
    }
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (cntx, index) => ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(list[index].image),
              ),
              onTap: () {
                clickPlace(context, list[index]);
              },
              subtitle: Text(list[index].placeLocation.address, maxLines: 2, 
                  style: Theme.of(context).textTheme.bodySmall),
              title: Text(
                list[index].name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ));
  }
}
