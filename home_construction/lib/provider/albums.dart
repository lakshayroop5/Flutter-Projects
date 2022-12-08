import 'package:flutter/material.dart';
import 'package:home_construction/models/album.dart' as img;
import 'dart:io';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Images with ChangeNotifier {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  List<img.Image> _imageList = [];

  List<img.Image> get imageList {
    return [..._imageList];
  }

  Future<File?> pickImage() async {
    final imageFromDevice =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFromDevice == null) return null;
    final imagePath = File(imageFromDevice.path);

    return imagePath;
  }

  Future<void> addImage(
      img.Image selectedImage, String title, String project) async {
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
    final url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/albums/$title/images.json");
    await http.post(
      url,
      body: json.encode(
        {
          'id': createdId,
          'imageFile': selectedImage.imageFile,
          'link': selectedImage.link,
          'date': selectedImage.date.toString(),
        },
      ),
    );

    final imageObject = img.Image(
      id: createdId,
      imageFile: selectedImage.imageFile,
      link: selectedImage.link,
      date: selectedImage.date,
    );

    if (imageObject.imageFile == null) return;
    _imageList.add(imageObject);
    notifyListeners();
  }

  Future<void> fetchListImages(String title, String project) async {
    final url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/albums/$title/images.json");
    final response = await http.get(url);
    if (json.decode(response.body) == null) {
      return;
    }
    final fetchedData = json.decode(response.body) as Map<String, dynamic>;

    // print(fetchedData);
    final List<img.Image> loadedImages = [];
    fetchedData.forEach((imageId, imageLink) {
      loadedImages.add(img.Image(
        id: imageLink['id'],
        link: imageLink['link'],
        date: DateTime.parse(imageLink['date']),
      ));
    });
    _imageList = loadedImages;
    notifyListeners();
  }

  Future<void> deleteImage(String id, String title, String project) async {
    final path = '$title/$id';
    final delRef = firebase_storage.FirebaseStorage.instance.ref().child(path);
    await delRef.delete();

    final url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/albums/$title/images.json");
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;
    String fid = '';
    data.forEach((key, value) {
      if (value['id'] == id) {
        fid = key;
      }
    });
    final url_ = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/albums/$title/images/$fid.json");
    if (fid.isEmpty) {
      return;
    }
    await http.delete(url_);
    _imageList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}

class Albums with ChangeNotifier {
  List<img.Album> _albums = [];

  void setAlbums(List<img.Album> list) {
    _albums = list;
  }

  List<img.Album> get getAlbums {
    return [..._albums];
  }
}
