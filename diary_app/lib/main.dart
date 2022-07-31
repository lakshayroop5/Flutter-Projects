import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jkl/screens/image_priew_screen.dart';
import 'package:jkl/screens/image_upload_screen.dart';
import 'package:provider/provider.dart';
import './screens/text_upload_screen.dart';
import './screens/content_grid_screen.dart';
import './screens/home_screen.dart';
import './providers/text.dart' as txt;
import './providers/texts.dart';
import './providers/image.dart' as img;
import './providers/images.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<txt.Text>(create: (context) => txt.Text()),
        ChangeNotifierProvider<img.Image>(create: (context) => img.Image()),
        ChangeNotifierProvider<Images>(create: ((context) => Images())),
        ChangeNotifierProvider<Texts>(create: (context) => Texts()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.purple),
        ),
        home: const HomeScreen(),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          ContentGridScreen.routeName: (context) => const ContentGridScreen(),
          TextUploadScreen.routeName: (context) => const TextUploadScreen(),
          ImageUploadScreen.routeName: (context) => const ImageUploadScreen(),
          ImagePriviewScreen.routeName: (context) => const ImagePriviewScreen(),
        },
      ),
    );
  }
}
