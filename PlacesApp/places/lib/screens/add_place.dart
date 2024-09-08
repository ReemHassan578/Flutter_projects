import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../providers/list_provider.dart';

class AddPlace extends ConsumerStatefulWidget {
  const AddPlace({super.key});

  @override
  ConsumerState<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends ConsumerState<AddPlace> {
  TextEditingController nameP = TextEditingController();

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
        padding :const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: nameP,
              decoration: const InputDecoration(
                  labelText: 'Title ', hintText: 'Enter title of place'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(icon:const Icon(Icons.add),
                onPressed: () {
                  
                  if(nameP.text.trim().isNotEmpty)
                 {
                  ref.read(listProvider.notifier).addPlace(Place(name: nameP.text));
                   Navigator.of(context).pop();
                   }
                },
                label: const Text('Add Place')),
          ],
        ),
      ),
    );
  }
}
