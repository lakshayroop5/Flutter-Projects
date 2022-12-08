import 'package:home_construction/models/material.dart';
import 'package:home_construction/models/worker.dart';

import 'album.dart';
import 'contact.dart';

class Project {
  final String name;
  List<Album> albums;
  List<Contact> contacts;
  List<MaterialItem> materials;
  List<Worker> workers;
  Project({
    required this.name,
    required this.albums,
    required this.contacts,
    required this.materials,
    required this.workers,
  });
}
