import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:places/models/place.dart';

class LocationContainer extends StatefulWidget {
  final void Function(PlaceLocation) pl;
  const LocationContainer(this.pl, {super.key});

  @override
  State<LocationContainer> createState() => _LocationContainerState();
}

class _LocationContainerState extends State<LocationContainer> {
  LocationData? locationData;
  bool isLoading = false;
  String? address;

  void getAddress() async {
    final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${locationData!.latitude},${locationData!.longitude}&key=AIzaSyBiDSOSh87L2SFBFM-im7UjuLkQ9gd1e3w');
    final http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      final resData = json.decode(res.body);
      setState(() {
        address = resData['results'][0]['formatted_address'];
        isLoading = false;
      });

      widget.pl(PlaceLocation(
          address: address!,
          lng: locationData!.longitude!,
          lat: locationData!.latitude!,
          mapImage: locationImage,
          ));

    }
  }

  String get locationImage {
    if(locationData==null || address == null) return '';
    return 'https://maps.googleapis.com/maps/api/staticmap?center=${locationData!.latitude},${locationData!.longitude}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C${locationData!.latitude},${locationData!.longitude}&key=AIzaSyBiDSOSh87L2SFBFM-im7UjuLkQ9gd1e3w';
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
    locationData = await location.getLocation();

    if (locationData == null) {
      return;
    }
    getAddress();
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
          child: isLoading == true ?const Center(child: CircularProgressIndicator()):
               address == null ?const Text('No location Chosen') : Image.network(locationImage)
             ,
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
                    onPressed: () {},
                    label: const Text('Select on Map')))
          ],
        )
      ],
    );
  }
}
