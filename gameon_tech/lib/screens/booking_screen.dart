import 'package:flutter/material.dart';
import 'package:gameon_tech/my_flutter_app_icons.dart';
import '/widgets/booking_screen/booking_card.dart';
import '/widgets/booking_screen/booking_header.dart';
import '/data/stadiums.dart' as data;

class BookingScreen extends StatelessWidget {
  static const String routeName = '/booking';
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<data.Stadium> list = data.Stadiums.list;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grounds'),
        actions: [
          SizedBox(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(MyFlutterApp.search),
                Icon(MyFlutterApp.filter),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(),
      ),
      body: Column(
        children: [
          const BookingHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) => BookingCard(list[index]),
            ),
          ),
        ],
      ),
    );
  }
}
