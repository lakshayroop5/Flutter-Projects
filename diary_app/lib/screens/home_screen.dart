import 'package:flutter/material.dart';
import 'package:jkl/widgets/home_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            HomeTile(
              title: 'Text',
            ),
            HomeTile(
              title: 'Images',
            ),
            HomeTile(
              title: 'Screen Shots',
            ),
          ],
        ),
      ),
    );
  }
}
