import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/models/place.dart';

class MapScreen extends StatelessWidget {
  final PlaceLocation placeLocation;
  final bool isSelecting ;
  const MapScreen(
      {super.key,
      this.placeLocation =
         const PlaceLocation(lat: 37.422, lng: -122.07, address: '', mapImage: ''),
          this.isSelecting=true,
          }
          );
//lat:37.422,lon:-122.07
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(isSelecting? 'Pick Your Location' : ' location ')), body: Text('test')
    // GoogleMap()
    );
  }
}
