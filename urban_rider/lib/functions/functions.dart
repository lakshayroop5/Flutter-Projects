import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:urban_rider/models/ride.dart';

class Functions {
  static Future<void> addRideInfo(Ride ride) async {
    final url = Uri.parse(
        "https://urban-rider-942ff-default-rtdb.firebaseio.com/user1/rides.json");
    await http.post(url,
        body: json.encode({
          'id': ride.id,
          'startImage': ride.startImage,
          'endImage': ride.endImage,
          'distance': ride.distance,
          'startTime': ride.startTime.toString(),
          'endTime': ride.endTime.toString(),
          'avgSpeed': ride.avgSpeed,
          'startLocation': {
            'latitude': ride.startLocation.latitude,
            'longitude': ride.startLocation.longitude,
          },
          'endLocation': {
            'latitude': ride.endLocation.latitude,
            'longitude': ride.endLocation.longitude,
          },
        }));
  }

  static Future<String> addImage(File image) async {
    final createdId = DateTime.now().toString();
    // uploading file to firebase storage
    final path = 'user1/$createdId';
    final file = image;
    final ref = firebase_storage.FirebaseStorage.instance.ref().child(path);
    firebase_storage.UploadTask? uploadtask = ref.putFile(file);

    final snapshot = await uploadtask.whenComplete(() => null);

    final link = await snapshot.ref.getDownloadURL();

    return link;
  }
}
