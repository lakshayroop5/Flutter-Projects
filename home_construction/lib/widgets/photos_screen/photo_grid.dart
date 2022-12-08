import 'package:flutter/material.dart';
import 'package:home_construction/models/album.dart' as img;
import 'package:home_construction/provider/albums.dart';
import 'package:home_construction/screens/photos_screen/image_upload_screen.dart';
import 'package:home_construction/widgets/photos_screen/photo_tile.dart';
import 'package:provider/provider.dart';

class PhotoGrid extends StatefulWidget {
  final String project;
  final String title;
  const PhotoGrid(this.project, this.title, {super.key});

  @override
  State<PhotoGrid> createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  bool _isInit = true;
  bool _isLoading = false;
  List<img.Image> list = [];

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      await Provider.of<Images>(context, listen: false)
          .fetchListImages(widget.title, widget.project)
          .then((value) {
        setState(() {
          list = Provider.of<Images>(context, listen: false).imageList;
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Provider.of<Images>(context, listen: false)
            .fetchListImages(widget.title, widget.project)
            .then((value) {
          setState(() {
            list = Provider.of<Images>(context, listen: false).imageList;
          });
        });
      },
      child: Stack(
        children: [
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : list.isEmpty
                  ? Center(
                      child: Text(
                        'No Photos',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 30,
                        childAspectRatio: 0.99,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: list.length,
                      itemBuilder: (context, i) => PhotoTile(
                        image: list[i],
                        project: widget.project,
                        title: widget.title,
                      ),
                    ),
          Positioned(
            bottom: 50,
            right: 40,
            child: SizedBox(
              height: 65,
              width: 65,
              child: FloatingActionButton(
                onPressed: () async {
                  Navigator.pushNamed(context, ImageUploadScreen.routeName,
                      arguments: [widget.project, widget.title]);
                },
                child: const Icon(
                  Icons.add,
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
