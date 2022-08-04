import 'package:flutter/material.dart';
import 'package:jkl/widgets/home_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('lib/assets/home background.jpg',
                fit: BoxFit.cover),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                HomeTile(
                  title: 'Text 📄',
                ),
                HomeTile(
                  title: 'Panda 🐼',
                ),
                HomeTile(
                  title: 'Koala 🐨',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
