import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../providers/list_provider.dart';
import 'map_screen.dart';

class PlaceDetails extends StatelessWidget {
  final Place place;

  const PlaceDetails({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: Stack(children: [
        Image.file(
          place.image,
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              InkWell(onTap:(){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapScreen(placeLocation: place.placeLocation ,isSelecting: false,),));
              },
                  child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(place.placeLocation.mapImage),
              )),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: Text(place.placeLocation.address,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
