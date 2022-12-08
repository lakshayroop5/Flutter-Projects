import 'package:flutter/material.dart';
import 'package:home_construction/models/material.dart';
import 'package:home_construction/screens/material_screen/add_record.dart';
import 'package:home_construction/screens/material_screen/material_detail.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../provider/projects.dart';

class RecordTile extends StatefulWidget {
  final Record record;
  final String materialId;
  final String project;
  const RecordTile(this.record, this.materialId, this.project, {super.key});

  @override
  State<RecordTile> createState() => RecordTileState();
}

class RecordTileState extends State<RecordTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // print(widget.record.description);
        Navigator.of(context).pushNamed(
          AddRecord.routeName,
          arguments: [widget.record, widget.materialId, widget.project],
        );
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Image.asset('assets/worker_icon.png'),
          ),
          title: Text(
            '\u{20B9} ${(widget.record.quantity * widget.record.pricePerUnit).toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(DateFormat.yMMMd().format(widget.record.date)),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Delete Record'),
                        content: const Text(
                            'Are you sure you want to delete this record?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No')),
                          TextButton(
                              onPressed: () {
                                Provider.of<Projects>(context, listen: false)
                                    .deleteRecord(widget.record,
                                        widget.materialId, widget.project);
                                Navigator.of(context).pop();
                                setState(() {
                                  MaterialItem temp = Provider.of<Projects>(
                                          context,
                                          listen: false)
                                      .findProject(widget.project)
                                      .materials
                                      .firstWhere((element) =>
                                          element.id == widget.materialId);
                                  Navigator.of(context).pushReplacementNamed(
                                      MaterialDetail.routeName,
                                      arguments: [temp, widget.project]);
                                });
                              },
                              child: const Text('Yes')),
                        ],
                      ));
            },
            icon: const Icon(
              Icons.delete,
              size: 30,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
