import 'package:home_construction/provider/projects.dart';
import 'package:home_construction/screens/material_screen/add_material.dart';
import 'package:home_construction/screens/material_screen/add_record.dart';
import 'package:home_construction/screens/material_screen/material_detail.dart';
import 'package:provider/provider.dart';

import '../../models/material.dart';
import 'package:flutter/material.dart';

class MaterialTile extends StatelessWidget {
  final MaterialItem material;
  final String project;
  const MaterialTile(this.material, this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        MaterialDetail.routeName,
        arguments: [material, project],
      ),
      child: Card(
        child: ListTile(
          leading: Image.asset('assets/material_icon.png',
              width: 50, height: 50, fit: BoxFit.cover),
          title: Text(
            material.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            material.unit,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AddRecord.routeName,
                      arguments: [
                        Record(
                          id: '',
                          quantity: 0,
                          date: DateTime.now(),
                          pricePerUnit: 0,
                        ),
                        material.id,
                        project
                      ],
                    );
                  },
                  icon: const Icon(Icons.add)),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) =>
                              AddMaterial(material, 'Edit Material', project),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 30,
                      ),
                      label: const Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Material'),
                            content: const Text(
                                'Are you sure you want to delete this material?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('No')),
                              TextButton(
                                  onPressed: () {
                                    Provider.of<Projects>(context,
                                            listen: false)
                                        .deleteMaterial(material, project);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Yes')),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 30,
                      ),
                      label: const Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
