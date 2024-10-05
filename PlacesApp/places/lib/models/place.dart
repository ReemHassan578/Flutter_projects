import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  String? id;
  final String name;
  final File image;
  final PlaceLocation placeLocation;

  Place(
      {String?  id,
      required this.name,
      required this.image,
      required this.placeLocation})
      : id = id ?? uuid.v4();
}

class PlaceLocation {
  final String address;
  final double lng;
  final double lat;
  //final String mapImage;

  const PlaceLocation({
    required this.address,
    required this.lng,
    required this.lat,
    //required this.mapImage
  });
}
