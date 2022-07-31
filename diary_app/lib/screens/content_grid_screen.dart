import 'package:flutter/material.dart';
import 'package:jkl/widgets/text_grid.dart';
import '../widgets/add_button.dart';
import '../widgets/image_grid.dart';

class ContentGridScreen extends StatelessWidget {
  static const String routeName = '/content-grid-screen';
  const ContentGridScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)!.settings.arguments as String;
    final dimension = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Stack(
        children: [
          if (title == 'Text') const TextGrid(),
          if (title == 'Images') const ImageGrid(),
          Positioned(
            bottom: dimension.height * 0.08,
            right: dimension.width * 0.08,
            child: AddButton('/$title-upload-screen'),
          ),
        ],
      ),
    );
  }
}
