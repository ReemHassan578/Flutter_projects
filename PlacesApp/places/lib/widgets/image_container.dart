import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageContainer extends StatefulWidget {
  final void Function(File) savePhoto;
  const ImageContainer({super.key, required this.savePhoto});

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  bool photoTaken = false;
  File? fileX;

  takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photoX = await picker.pickImage(source: ImageSource.camera);
    if (photoX == null) {
      return;
    } else {
      setState(() {
        fileX = File(photoX.path);
        photoTaken = true;
      });
      widget.savePhoto(fileX!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      height: 200,
      alignment: Alignment.center,
      width: double.infinity,
      child: !photoTaken
          ? TextButton.icon(
              label: const Text('Take a photo'),
              onPressed: takePhoto,
              icon: const Icon(Icons.camera),
            )
          : GestureDetector(
              onTap: takePhoto,
              child: Image.file(fileX!,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity)),
    );
  }
}
