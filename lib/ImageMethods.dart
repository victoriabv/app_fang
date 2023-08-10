import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageMethods {
  Future<String> imageGallery([DocumentSnapshot? documentSnapshot]) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage == null) {
      throw Exception('No se seleccionó ninguna imagen.');
    }

    File imageFile = File(pickedImage.path);

    String imageUrl = await imageUpload(imageFile);

    return imageUrl;
  }

  Future<String> imageCamera([DocumentSnapshot? documentSnapshot]) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);

    if (pickedImage == null) {
      throw Exception('No se seleccionó ninguna imagen.');
    }

    File imageFile = File(pickedImage.path);

    String imageUrl = await imageUpload(imageFile);

    return imageUrl;
  }

  Future<String> imageUpload(File imageFile) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}');
    await ref.putFile(imageFile);

    String imageUrl = await ref.getDownloadURL();
    print('Image URL: $imageUrl');

    return imageUrl;
  }
}
