import 'package:flutter/material.dart';
import 'package:home_construction/models/material.dart';
import 'package:home_construction/screens/material_screen/add_material.dart';
import 'package:home_construction/widgets/material_screen/material_tile.dart';

import '../add_button.dart';

class MaterialList extends StatelessWidget {
  final List<MaterialItem> list;
  final String project;
  const MaterialList(this.list, this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 5,
          ),
          itemBuilder: (context, i) => MaterialTile(list[i], project),
          itemCount: list.length,
        ),
        AddButton(
          AddMaterial(
              MaterialItem(
                id: '',
                name: '',
                unit: '',
                quantity: 0,
                total: 0,
                records: [],
              ),
              'Add Material',
              project),
          project,
        ),
      ],
    );
  }
}
