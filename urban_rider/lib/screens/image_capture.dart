import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urban_rider/models/ride.dart';
import 'package:urban_rider/screens/final_info.dart';
import 'package:urban_rider/screens/location_traking_screen.dart';
import '../functions/functions.dart';

class ImageCaptureScreen extends StatefulWidget {
  static const routeName = '/Images-upload-screen';
  const ImageCaptureScreen({Key? key}) : super(key: key);

  @override
  State<ImageCaptureScreen> createState() => _ImageCaptureScreenState();
}

class _ImageCaptureScreenState extends State<ImageCaptureScreen> {
  XFile? _imageFile;
  int temp = 0;
  String title = 'Screen 1';
  Ride ride = Ride(
    id: DateTime.now().toString(),
    startImage: '',
    endImage: '',
    distance: 0,
    time: '',
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    avgSpeed: 0,
    startLocation: UserLocation(0, 0),
    endLocation: UserLocation(0, 0),
  );

  void pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      maxWidth: 150,
    );
    setState(() {
      _imageFile = image;
      if (temp == 0 && _imageFile != null) {
        title = 'Screen 2';
      } else if (temp == 1 && _imageFile != null) {
        title = 'Screen 5';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (temp == 0) title = 'Screen 1';
    if (temp == 1) title = 'Screen 4';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: _imageFile == null
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.42,
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Colors.black)),
                      padding: const EdgeInsets.all(8.0),
                      child: const Text('No Image'),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: double.infinity,
                      child: Image.file(
                        File(_imageFile!.path),
                        fit: BoxFit.cover,
                        // width: double.infinity,
                        // height: MediaQuery.of(context).size.height * 0.5,
                      ),
                    ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            _imageFile == null
                ? SizedBox(
                    width: 108,
                    height: 108,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        pickImage();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Take Image',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: pickImage,
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Retake',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      temp == 0
                          ? ElevatedButton(
                              onPressed: () async {
                                final imageLink = await Functions.addImage(
                                    File(_imageFile!.path));
                                ride.startImage = imageLink;
                                if (!mounted) return;
                                Navigator.of(context)
                                    .pushNamed(LocationTrackingPage.routeName,
                                        arguments: ride)
                                    .then((value) {
                                  setState(() {
                                    temp = 1;
                                    _imageFile = null;
                                    ride = value as Ride;
                                  });
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Start Ride >',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                final imageLink = await Functions.addImage(
                                    File(_imageFile!.path));
                                ride.endImage = imageLink;
                                if (!mounted) return;
                                Navigator.of(context)
                                    .pushNamed(FinalInfo.routeName,
                                        arguments: ride)
                                    .then((value) {
                                  setState(() {
                                    temp = 0;
                                    _imageFile = null;
                                    ride = Ride(
                                      id: DateTime.now().toString(),
                                      startImage: '',
                                      endImage: '',
                                      distance: 0,
                                      time: '',
                                      startTime: DateTime.now(),
                                      endTime: DateTime.now(),
                                      avgSpeed: 0,
                                      startLocation: UserLocation(0, 0),
                                      endLocation: UserLocation(0, 0),
                                    );
                                  });
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Finish Ride',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            )
          ],
        ),
      ),
    );
  }
}
