import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/album.dart' as img;
import '../../provider/albums.dart';

class ImageUploadScreen extends StatefulWidget {
  static const routeName = '/Images-upload-screen';
  const ImageUploadScreen({Key? key}) : super(key: key);

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  img.Image image = img.Image(id: '', date: null, imageFile: null, link: '');
  DateTime? _selectedDate = null;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then(
      (value) {
        if (value == null) {
          return;
        }
        setState(() {
          _selectedDate = value;
        });
        image.date = _selectedDate;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('re');
    final data = ModalRoute.of(context)!.settings.arguments as List;
    final project = data[0];
    final title = data[1];
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
                onPressed: _presentDatePicker,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _selectedDate == null
                      ? const Text(
                          'Select Date',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      : Text(
                          DateFormat('dd-MM-yyyy')
                              .format(_selectedDate!)
                              .toString(),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            ElevatedButton(
                onPressed: () async {
                  image.id = DateTime.now().toString();
                  if (_selectedDate == null) image.date = DateTime.now();
                  image.imageFile = await images.pickImage();
                  setState(() {});
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
                images.addImage(image, title, project);
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
