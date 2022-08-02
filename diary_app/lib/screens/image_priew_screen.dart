import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/image.dart' as img;
import '../providers/images.dart';

class ImagePriviewScreen extends StatelessWidget {
  static const routeName = '/image-privew-screen';

  const ImagePriviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageObject = ModalRoute.of(context)!.settings.arguments as img.Image;
    final imageLink = imageObject.link;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Are you sure ?'),
                    content:
                        const Text('The memory will be permanentaly deleted !'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Provider.of<Images>(context, listen: false)
                              .deleteImage(imageObject.id!);
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Confirm'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          clipBehavior: Clip.none,
          minScale: 1,
          maxScale: 6,
          child: Image.network(imageLink!),
        ),
      ),
    );
  }
}
