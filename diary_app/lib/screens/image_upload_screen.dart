import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/image.dart' as img;
import '../providers/images.dart';

class ImageUploadScreen extends StatefulWidget {
  static const routeName = '/Images-upload-screen';
  const ImageUploadScreen({Key? key}) : super(key: key);

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  @override
  Widget build(BuildContext context) {
    final image = Provider.of<img.Image>(context);
    final images = Provider.of<Images>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memories'),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: image.imageFile == null
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.42,
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Colors.black)),
                      padding: const EdgeInsets.all(8.0),
                      child: const Text('empty'),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: double.infinity,
                      child: Image.file(
                        image.imageFile!,
                        fit: BoxFit.cover,
                        // width: double.infinity,
                        // height: MediaQuery.of(context).size.height * 0.5,
                      ),
                    ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            ElevatedButton(
                onPressed: () {
                  images.pickImage(image);
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Choose Image',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            ElevatedButton(
              onPressed: () async {
                if (image.imageFile == null) return;
                images.addImage(image);
                image.imageFile = null;
                Navigator.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Upload Image',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
