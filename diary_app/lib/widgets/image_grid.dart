import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/images.dart';
import './image_grid_tile.dart';
import 'package:firebase_core/firebase_core.dart';

class ImageGrid extends StatefulWidget {
  const ImageGrid({Key? key}) : super(key: key);

  @override
  State<ImageGrid> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Images>(context).fetchListImages().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
