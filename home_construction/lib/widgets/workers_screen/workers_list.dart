import 'package:flutter/material.dart';
import 'package:home_construction/models/worker.dart';
import 'package:home_construction/screens/worker_screen/add_worker.dart';
import 'package:home_construction/widgets/add_button.dart';
import 'package:home_construction/widgets/workers_screen/workers_tile.dart';

class WorkersList extends StatelessWidget {
  final List<Worker> list;
  final String project;
  const WorkersList(this.list, this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 5,
          ),
          itemBuilder: (context, i) => WorkersTile(list[i], project),
          itemCount: list.length,
        ),
        AddButton(
          AddWorker(
              Worker(
                id: '',
                name: '',
                totalAmount: 0,
                transactions: [],
              ),
              'Add Worker',
              project),
          project,
        ),
      ],
    );
  }
}
