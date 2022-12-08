import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:home_construction/screens/photos_screen/image_upload_screen.dart';
import 'firebase_options.dart';
import 'package:home_construction/provider/albums.dart';
import 'package:home_construction/provider/projects.dart';
import 'package:home_construction/screens/material_screen/add_record.dart';
import 'package:home_construction/screens/material_screen/material_detail.dart';
import 'package:home_construction/screens/menu_screen.dart';
import 'package:home_construction/screens/photos_view_screen.dart';
import 'package:home_construction/screens/worker_screen/add_transaction.dart';
import 'package:home_construction/screens/worker_screen/worker_detail.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/photos_screen/image_priew_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Projects()),
        ChangeNotifierProvider(create: (context) => Albums()),
        ChangeNotifierProvider(create: (context) => Images()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const HomeScreen(),
        routes: {
          MenuScreen.routeName: (context) => const MenuScreen(),
          PhotosViewScreen.routeName: (context) => const PhotosViewScreen(),
          WorkerDetail.routeName: (context) => const WorkerDetail(),
          MaterialDetail.routeName: (context) => const MaterialDetail(),
          AddTransaction.routeName: (context) => const AddTransaction(),
          AddRecord.routeName: (context) => const AddRecord(),
          ImageUploadScreen.routeName: (context) => const ImageUploadScreen(),
          ImagePreviewScreen.routeName: (context) => const ImagePreviewScreen(),
        },
      ),
    );
  }
}
