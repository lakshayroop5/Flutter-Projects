import 'package:flutter/material.dart';
import 'package:gameon_tech/data/stadiums.dart';
import 'package:gameon_tech/widgets/detail_screen/detail_card.dart';
import 'package:gameon_tech/widgets/detail_screen/detail_header.dart';

class DetailScreen extends StatelessWidget {
  static const String routeName = '/detail';
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Stadium;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Grounds'),
        ),
        drawer: Drawer(
          child: Container(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              DetailHeader(data),
              const SizedBox(
                height: 12,
              ),
              const DetailCard('20', '10', '₹ 3000'),
              const DetailCard('30', '03', '₹ 6000'),
            ],
          ),
        ));
  }
}
