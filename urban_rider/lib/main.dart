import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:urban_rider/firebase_options.dart';
import 'package:urban_rider/screens/final_info.dart';
import '/screens/image_capture.dart';
import 'test.dart';
import 'screens/location_traking_screen.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          elevation: 0,
        ),
      ),
      home: const ImageCaptureScreen(),
      routes: {
        LocationTrackingPage.routeName: (context) =>
            const LocationTrackingPage(),
        ImageCaptureScreen.routeName: (context) => const ImageCaptureScreen(),
        FinalInfo.routeName: (context) => const FinalInfo(),
      },
    );
  }
}
