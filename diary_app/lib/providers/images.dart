import 'dart:io';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './image.dart' as img;

class Images with ChangeNotifier {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  List<img.Image> _imageList = [];

  List<img.Image> get imageList {
    return [..._imageList];
  }

  Future<void> pickImage(img.Image imageObject) async {
    final imageFromDevice =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFromDevice == null) return;
    final imagePath = File(imageFromDevice.path);
    imageObject.imageFile = imagePath;
    notifyListeners();
  }

  Future<void> addImage(img.Image selectedImage) async {
    final path = 'files/${selectedImage.id}';
    final file = selectedImage.imageFile;
    final ref = firebase_storage.FirebaseStorage.instance.ref().child(path);
    firebase_storage.UploadTask? uploadtask = ref.putFile(file!);

    final snapshot = await uploadtask.whenComplete(() => null);

    selectedImage.link = snapshot.ref.getDownloadURL() as String?;

    final imageObject = img.Image(
      id: DateTime.now().toString(),
      imageFile: selectedImage.imageFile,
      link: selectedImage.link,
    );
    if (imageObject.imageFile == null) return;
    _imageList.add(imageObject);
    notifyListeners();
  }

  // Future<void> fetchListImages() async {
  //   firebase_storage.ListResult result = await storage.ref('files').listAll();
  //   _imageList = result;
  // }

  void deleteImage(String id) {
    _imageList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
