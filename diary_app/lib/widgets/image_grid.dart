import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/images.dart';
import './image_grid_tile.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadedImage = Provider.of<Images>(context).imageList;
    return GridView.builder(
      // padding: const EdgeInsets.only(top: 10),
      itemCount: loadedImage.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        // childAspectRatio: 3 / 2,
        // mainAxisSpacing: 10,
        // crossAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedImage[i],
        child: ImageGridTile(
          loadedImage[i],
        ),
      ),
    );
  }
}
