import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../../components/constants.dart';

class CloudStorageHelper {
  static final storageRef = FirebaseStorage.instance.ref();

  static Future<TaskSnapshot> uploadImage(String path, String type) async {
    Reference refImage = storageRef.child('users/$uId/$type.jpeg');
    File file = File(path);
    return refImage.putFile(file);
  }

  static Future<TaskSnapshot> uploadPostImage(String path) async {
    Reference refImage =
        storageRef.child('posts/$uId/${Uri.file(path).pathSegments.last}.jpeg');
    File file = File(path);
    return refImage.putFile(file);
  }
}
