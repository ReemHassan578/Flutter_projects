import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation placeLocation;
  final bool isSelecting;
  const MapScreen({
    super.key,
    this.placeLocation =
        const PlaceLocation(lat: 37.422, lng: -122.07, address: ''),
    this.isSelecting = true,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? pos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              widget.isSelecting ? 'Pick Your Location' : 'Your Location '),
          actions: [
            if (widget.isSelecting)
              IconButton(
                  onPressed: pos == null
                      ? null
                      : () {
                          Navigator.of(context).pop(pos);
                        },
                  icon: const Icon(Icons.save))
          ],
        ),
        body: GoogleMap(
          onTap: !widget.isSelecting
              ? null
              : (argument) {
                  setState(() {
                    pos = argument;
                  });
                },
          markers: (widget.isSelecting && pos == null)
              ? {}
              : {
                  Marker(
                    markerId: const MarkerId('x1'),
                    position: !widget.isSelecting
                        ? LatLng(
                            widget.placeLocation.lat, widget.placeLocation.lng)
                        : pos!,
                  )
                },
          initialCameraPosition: CameraPosition(
              zoom: 16,
              target:
                  LatLng(widget.placeLocation.lat, widget.placeLocation.lng)),
        ));
  }
}
