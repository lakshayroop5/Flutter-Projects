import 'package:flutter/material.dart';
import 'package:gameon_tech/screens/booking_screen.dart';
import 'package:gameon_tech/screens/detail_screen.dart';
import 'package:gameon_tech/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            toolbarHeight: 86,
            color: Color(0xff088F81),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(8)))),
        fontFamily: 'Poppins',
        primaryColor: const Color(0xff088F81),
      ),
      home: const HomeScreen(),
      routes: {
        DetailScreen.routeName: (context) => const DetailScreen(),
        BookingScreen.routeName: (context) => const BookingScreen(),
      },
    );
  }
}
