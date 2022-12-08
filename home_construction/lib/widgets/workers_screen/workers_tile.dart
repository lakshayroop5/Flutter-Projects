import 'package:flutter/material.dart';
import 'package:home_construction/models/worker.dart';
import 'package:home_construction/provider/projects.dart';
import 'package:home_construction/screens/worker_screen/add_transaction.dart';
import 'package:home_construction/screens/worker_screen/add_worker.dart';
import 'package:home_construction/screens/worker_screen/worker_detail.dart';
import 'package:provider/provider.dart';

class WorkersTile extends StatelessWidget {
  final Worker worker;
  final String project;
  const WorkersTile(this.worker, this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        WorkerDetail.routeName,
        arguments: [worker, project],
      ),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Image.asset('assets/worker_icon.png'),
          ),
          title: Text(
            worker.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text('\u{20B9} ${worker.totalAmount.toStringAsFixed(0)}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AddTransaction.routeName, arguments: [
                      Transaction(
                        id: '',
                        amount: 0,
                        date: DateTime.now(),
                        description: '',
                      ),
                      worker.id,
                      project
                    ]);
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
                              AddWorker(worker, 'Edit Worker', project),
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
                                  title: const Text('Delete Worker'),
                                  content: const Text(
                                      'Are you sure you want to delete this worker?'),
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
                                              .deleteWorker(worker, project);
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Yes')),
                                  ],
                                ));
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
