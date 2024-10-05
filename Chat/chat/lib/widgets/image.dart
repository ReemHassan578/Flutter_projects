import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageProfile extends StatefulWidget {
  final void Function(File) saveImage;
  const ImageProfile(this.saveImage, {super.key});

  @override
  State<ImageProfile> createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {
  File? image;
  pickImageProfile() async {
    final XFile? imagePicker = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (imagePicker == null) {
      return;
    }
    setState(() {
      image = File(imagePicker.path);
    });
    widget.saveImage(image!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: image == null ? null : FileImage(image!),
          radius: 40,
          // child: image == null ? null : Image.file(image!),
        ),
        TextButton.icon(
          onPressed: pickImageProfile,
          icon: const Icon(Icons.photo),
          label: const Text('Take Photo'),
        ),
      ],
    );
  }
}
