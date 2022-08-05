import 'package:flutter/material.dart';
import 'package:jkl/widgets/text_grid.dart';
import '../widgets/add_button.dart';
import '../widgets/image_grid.dart';

class ContentGridScreen extends StatefulWidget {
  static const String routeName = '/content-grid-screen';
  const ContentGridScreen({Key? key}) : super(key: key);

  @override
  State<ContentGridScreen> createState() => _ContentGridScreenState();
}

class _ContentGridScreenState extends State<ContentGridScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  String setTitle(title) {
    if (title == 'Text 📄') {
      return 'text';
    }
    if (title == 'Panda 🐼') {
      return 'images';
    }
    if (title == 'Koala 🐨') {
      return 'koala';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)!.settings.arguments as String;
    final dimension = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Stack(
        children: [
          if (title == 'Text 📄') const TextGrid(),
          if (title == 'Panda 🐼') const ImageGrid('images'),
          if (title == 'Koala 🐨') const ImageGrid('koala'),
          Positioned(
              bottom: dimension.height * 0.08,
              right: dimension.width * 0.08,
              child: title == 'Text 📄'
                  ? AddButton(
                      routeName: '/Text-upload-screen',
                    )
                  : AddButton(
                      routeName: '/Images-upload-screen',
                      title: setTitle(title))),
        ],
      ),
    );
  }
}
