import 'package:flutter/material.dart';
import 'package:home_construction/provider/albums.dart';
import 'package:home_construction/widgets/add_button.dart';
import 'package:provider/provider.dart';

import '../../models/album.dart';
import '../../screens/photos_screen/add_album.dart';
import 'album_tile.dart';

class AlbumList extends StatelessWidget {
  final List<Album> list;
  final String project;

  const AlbumList(this.project, this.list, {super.key});

  // bool _isInit = true;
  @override
  Widget build(BuildContext context) {
    Provider.of<Albums>(context).setAlbums(list);
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          itemCount: list.length,
          itemBuilder: (context, i) => AlbumTile(project, list[i]),
        ),
        AddButton(
          AddAlbum(
              Album(
                id: DateTime.now().toString(),
                name: '',
                photos: [],
              ),
              'Add Album',
              project),
          project,
        ),
      ],
    );
  }
}
