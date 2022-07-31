import 'package:flutter/material.dart';
import 'package:jkl/providers/images.dart';
import 'package:provider/provider.dart';
import '../screens/image_priew_screen.dart';
import '../providers/image.dart' as img;
import '../providers/images.dart';

class ImageGridTile extends StatelessWidget {
  final img.Image image;
  const ImageGridTile(this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ImagePriviewScreen.routeName, arguments: image);
      },
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          Provider.of<Images>(context, listen: false).deleteImage(image.id!);
        },
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Are you sure ?'),
              content: const Text('The memory will be permanentaly deleted !'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: const Text('Confirm'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          );
        },
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
          child: Image.file(
            image.imageFile!,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}