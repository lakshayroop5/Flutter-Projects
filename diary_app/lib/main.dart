import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          appBarTheme: const AppBarTheme(color: Colors.red),
        ),
        home: SplashScreen(),
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

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedSplashScreen(
      splash: Image.asset(
        'lib/assets/splash screen.jpeg',
        fit: BoxFit.cover,
      ),
      nextScreen: const HomeScreen(),
      animationDuration: const Duration(seconds: 1),
      splashIconSize: double.infinity,
    );
  }
}
