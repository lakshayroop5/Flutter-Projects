import 'package:flutter/material.dart';
import 'package:home_construction/models/album.dart' as img;
import 'package:home_construction/provider/projects.dart';
import 'package:home_construction/screens/photos_screen/add_album.dart';
import 'package:home_construction/screens/photos_view_screen.dart';
import 'package:provider/provider.dart';

class AlbumTile extends StatelessWidget {
  final String project;
  final img.Album title;
  const AlbumTile(this.project, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(PhotosViewScreen.routeName,
            arguments: [project, title.name]);
      },
      child: Card(
        child: ListTile(
          title: Text(title.name),
          leading: CircleAvatar(
            child: Image.asset('assets/album_tile_photo.png'),
            // child: Image.asset('assets/album_tile_photo.png'),
          ),
          trailing: PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              // PopupMenuItem(
              //   child: TextButton.icon(
              //     onPressed: () {
              //       showModalBottomSheet(
              //         context: context,
              //         builder: (_) => AddAlbum(title, 'Edit Contact', project),
              //       );
              //     },
              //     icon: const Icon(
              //       Icons.edit,
              //       size: 30,
              //     ),
              //     label: const Text(
              //       'Edit',
              //       style: TextStyle(
              //         fontSize: 20,
              //       ),
              //     ),
              //   ),
              // ),
              PopupMenuItem(
                child: TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: ((_) => AlertDialog(
                            title: const Text('Delete!'),
                            content: const Text(
                                'Project will be permanentally deleted!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Provider.of<Projects>(context, listen: false)
                                      .deleteAlbum(title, project);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          )),
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 30,
                  ),
                  label: const Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
