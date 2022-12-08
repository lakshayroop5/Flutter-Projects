import 'package:flutter/material.dart';
import 'package:home_construction/provider/albums.dart';
import 'package:home_construction/screens/photos_screen/image_priew_screen.dart';
import 'package:provider/provider.dart';
import '../../models/album.dart' as img;
import 'package:intl/intl.dart';

class PhotoTile extends StatelessWidget {
  final img.Image image;
  final String project;
  final String title;
  const PhotoTile(
      {required this.image,
      required this.project,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ImagePreviewScreen.routeName, arguments: {
          'image': image,
          'project': project,
          'title': title,
        });
      },
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) async {
          Provider.of<Images>(context, listen: false)
              .deleteImage(image.id!, title, project);
        },
        confirmDismiss: (direction) => showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text('Do you want to delete this image?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('No')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Yes')),
                  ],
                ))),
        background: Container(
          padding: const EdgeInsets.all(12),
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 30,
          ),
        ),
        child: GridTile(
          footer: Center(
              child: Text(
            DateFormat.yMMMd().format(image.date!),
            style: const TextStyle(backgroundColor: Colors.white, fontSize: 18),
          )),
          child: Card(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.network(image.link!),
            ),
          ),
        ),
      ),
    );
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     ClipRRect(
    //       borderRadius: BorderRadius.circular(25),
    //       child: GridTile(
    //         child: Card(
    //           child: image,
    //         ),
    //       ),
    //     ),
    //     Text(DateFormat.yMMMd().format(date)),
    //   ],
    // );
  }
}
