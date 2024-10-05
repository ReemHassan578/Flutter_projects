import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_pro;
import 'package:path/path.dart' as path;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';
import '../providers/list_provider.dart';
import '../widgets/image_container.dart';
import '../widgets/location_container.dart';
import 'map_screen.dart';

class AddPlace extends ConsumerStatefulWidget {
  const AddPlace({super.key});

  @override
  ConsumerState<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends ConsumerState<AddPlace> {
  TextEditingController nameP = TextEditingController();
  File? image;
  PlaceLocation? placelocation;
  LatLng? pos;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    nameP.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: nameP,
              decoration: const InputDecoration(
                  labelText: 'Title ', hintText: 'Enter title of place'),
            ),
            const SizedBox(height: 12),
            ImageContainer(savePhoto: (file) {
              image = file;
            }),
            const SizedBox(height: 12),
            LocationContainer((value) {
              placelocation = value;
            }, pickLocation),
            const SizedBox(height: 12),
            ElevatedButton.icon(
                icon: isLoading
                    ? const CircularProgressIndicator()
                    : const Icon(Icons.add),
                onPressed: () async {
                  if (nameP.text.trim().isNotEmpty &&
                      image != null &&
                      placelocation != null) {
                    setState(() {
                      isLoading = true;
                    });

                    final Directory directory =
                        await path_pro.getApplicationDocumentsDirectory();
                    final String fileName = path.basename(image!.path);
                    final File imagee =
                        await image!.copy('${directory.path}/$fileName');
                    setState(() {
                      isLoading = false;
                    });
                    ref.read(listProvider.notifier).addPlace(Place(
                        name: nameP.text,
                        image: imagee,
                        placeLocation: placelocation!));
                    Navigator.of(context).pop();
                  } else {
                    return;
                  }
                },
                label: const Text('Add Place')),
          ],
        ),
      ),
    );
  }

  Future<LatLng?> pickLocation() async {
    final LatLng? value =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      builder: (context) => const MapScreen(),
    ));
    setState(() {
      pos = value;
    });
    return pos;
  }
}
