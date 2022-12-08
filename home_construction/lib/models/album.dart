import 'dart:io';

class Album {
  String id;
  final String name;
  List<Image>? photos = [];

  Album({required this.id, required this.name, this.photos});
}

class Image {
  String? id;
  File? imageFile;
  String? link;
  DateTime? date;
  Image({required this.id, this.imageFile, this.link, this.date});
}
