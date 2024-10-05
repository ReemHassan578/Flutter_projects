import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:places/models/place.dart';

class LocationContainer extends StatefulWidget {
  final void Function(PlaceLocation) pl;
  //final LatLng? pos;
  final Future<LatLng?> Function() choosePlace;
  const LocationContainer(this.pl, this.choosePlace, {super.key});

  @override
  State<LocationContainer> createState() => _LocationContainerState();
}

class _LocationContainerState extends State<LocationContainer> {
  //LocationData? locationData;
  PlaceLocation? pickedPlace;
  bool isLoading = false;
  String? address;

  void getAddress(double long, double lat) async {
    final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyBiDSOSh87L2SFBFM-im7UjuLkQ9gd1e3w');
    final http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      final resData = json.decode(res.body);
      setState(() {
        address = resData['results'][0]['formatted_address'];
        pickedPlace = PlaceLocation(address: address!, lng: long, lat: lat);
        isLoading = false;
      });
      savePlace();
    }
  }

  savePlace() {
    widget.pl(pickedPlace!);
  }

  String get locationImage {
    if (pickedPlace == null || address == null) return '';
    return 'https://maps.googleapis.com/maps/api/staticmap?center=${pickedPlace!.lat},${pickedPlace!.lng}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C${pickedPlace!.lat},${pickedPlace!.lng}&key=...';
  }

  void getCurrent() async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      isLoading = true;
    });
    LocationData locationData = await location.getLocation();

    /* pickedPlace = PlaceLocation(
        address: address!,
        lng: locationData.longitude!,
        lat: locationData.latitude!,
        mapImage: locationImage);*/

    getAddress(locationData.longitude!, locationData.latitude!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all()),
          alignment: Alignment.center,
          child: isLoading == true
              ? const Center(child: CircularProgressIndicator())
              : address == null
                  ? const Text('No location Chosen')
                  : Image.network(locationImage),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: TextButton.icon(
                    icon: const Icon(Icons.location_on),
                    onPressed: () {
                      getCurrent();
                    },
                    label: const Text('Get Current Location'))),
            Expanded(
                child: TextButton.icon(
                    icon: const Icon(Icons.map),
                    onPressed: () {
                      pickLocation();
                    },
                    label: const Text('Select on Map')))
          ],
        )
      ],
    );
  }

  void pickLocation() async {
    final LatLng? pos = await widget.choosePlace();
    if (pos == null) return;
    log('location');

    getAddress(pos.longitude, pos.latitude);
  }
}
