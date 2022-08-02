import 'dart:io';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './image.dart' as img;
import 'package:firebase_core/firebase_core.dart';

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
    // uploading file to firebase storage
    final path = 'files/${selectedImage.id}';
    final file = selectedImage.imageFile;
    final ref = firebase_storage.FirebaseStorage.instance.ref().child(path);
    firebase_storage.UploadTask? uploadtask = ref.putFile(file!);

    final snapshot = await uploadtask.whenComplete(() => null);

    selectedImage.link = snapshot.ref.getDownloadURL() as String?;

    // adding image object to database
    final url =
        Uri.parse('https://jklf-aa08d-default-rtdb.firebaseio.com/images.json');
    final response = await http.put(
      url,
      body: json.encode(
        {
          'imageFile': selectedImage.imageFile,
          'link': selectedImage.link,
        },
      ),
    );

    final imageObject = img.Image(
      id: json.decode(response.body)['name'],
      imageFile: selectedImage.imageFile,
      link: selectedImage.link,
    );

    if (imageObject.imageFile == null) return;
    _imageList.add(imageObject);
    notifyListeners();
  }

  Future<void> fetchListImages() async {
    final url =
        Uri.parse('https://jklf-aa08d-default-rtdb.firebaseio.com/images.json');
    final response = await http.get(url);
    final fetchedData = json.decode(response.body);
    print(fetchedData);
  }

  void deleteImage(String id) {
    _imageList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
