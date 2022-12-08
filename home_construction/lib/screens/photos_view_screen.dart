import 'package:flutter/material.dart';
import 'package:home_construction/widgets/photos_screen/photo_grid.dart';

class PhotosViewScreen extends StatelessWidget {
  static const routeName = '/photo-view-screen';
  const PhotosViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as List;
    final String project = data[0];
    final String title = data[1];
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: PhotoGrid(project, title),
    );
  }
}
