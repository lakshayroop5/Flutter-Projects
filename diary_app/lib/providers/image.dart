import 'dart:io';

import 'package:flutter/material.dart';

class Image with ChangeNotifier {
  final String? id;
  File? imageFile;
  String? link;

  Image({this.id, this.imageFile, this.link});
}
