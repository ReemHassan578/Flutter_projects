import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../providers/list_provider.dart';

class PlaceDetails extends StatelessWidget {
  final Place place;
  
  const PlaceDetails({super.key,required this.place});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text(place.name),
      ),
      body: Center(
        child :Text(place.id),
      ) ,
    );
  }
}