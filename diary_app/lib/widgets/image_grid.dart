import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/images.dart';
import './image_grid_tile.dart';

class ImageGrid extends StatefulWidget {
  final String title;
  // ignore: use_key_in_widget_constructors
  const ImageGrid(this.title);

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
      Provider.of<Images>(context).fetchListImages(widget.title).then((value) {
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
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
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
              child: ImageGridTile(loadedImage[i], widget.title),
            ),
          );
  }
}
