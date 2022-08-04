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

  Future<void> addImage(img.Image selectedImage, String title) async {
    final createdId = DateTime.now().toString();
    // uploading file to firebase storage
    final path = '$title/$createdId';
    final file = selectedImage.imageFile;
    final ref = firebase_storage.FirebaseStorage.instance.ref().child(path);
    firebase_storage.UploadTask? uploadtask = ref.putFile(file!);

    final snapshot = await uploadtask.whenComplete(() => null);

    final link = await snapshot.ref.getDownloadURL();

    selectedImage.link = link;

    // adding image object to database
    final url =
        Uri.parse('https://jklf-aa08d-default-rtdb.firebaseio.com/$title.json');
    await http.post(
      url,
      body: json.encode(
        {
          'id': createdId,
          'imageFile': selectedImage.imageFile,
          'link': selectedImage.link,
        },
      ),
    );

    final imageObject = img.Image(
      id: createdId,
      imageFile: selectedImage.imageFile,
      link: selectedImage.link,
    );

    if (imageObject.imageFile == null) return;
    _imageList.add(imageObject);
    notifyListeners();
  }

  Future<void> fetchListImages(String title) async {
    final url =
        Uri.parse('https://jklf-aa08d-default-rtdb.firebaseio.com/$title.json');
    final response = await http.get(url);
    final fetchedData = json.decode(response.body) as Map<String, dynamic>;
    // print(fetchedData);
    final List<img.Image> loadedImages = [];
    fetchedData.forEach((imageId, imageLink) {
      loadedImages.add(img.Image(
        id: imageLink['id'],
        link: imageLink['link'],
      ));
    });
    _imageList = loadedImages;
    notifyListeners();
  }

  Future<void> deleteImage(String id, String title) async {
    final path = '$title/$id';
    final delRef = firebase_storage.FirebaseStorage.instance.ref().child(path);
    await delRef.delete();

    final url =
        Uri.parse('https://jklf-aa08d-default-rtdb.firebaseio.com/$title.json');
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;
    String fid = '';
    data.forEach((key, value) {
      if (value['id'] == id) {
        fid = key;
      }
    });
    final url_ = Uri.parse(
        'https://jklf-aa08d-default-rtdb.firebaseio.com/$title/$fid.json');
    if (fid.isEmpty) {
      return;
    }
    await http.delete(url_);
    _imageList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
