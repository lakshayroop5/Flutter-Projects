import 'package:flutter/material.dart';
import '../widgets/home_screen/home_tile_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Sweet Home')),
      body: const HomeTileList(),
    );
  }
}
