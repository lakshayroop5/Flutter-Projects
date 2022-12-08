import 'package:flutter/material.dart';
import 'package:home_construction/models/worker.dart';
import 'package:home_construction/screens/worker_screen/add_transaction.dart';
import 'package:home_construction/screens/worker_screen/worker_detail.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../provider/projects.dart';

class TransactionTile extends StatefulWidget {
  final Transaction transaction;
  final String workerId;
  final String project;
  const TransactionTile(this.transaction, this.workerId, this.project,
      {super.key});

  @override
  State<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AddTransaction.routeName,
          arguments: [widget.transaction, widget.workerId, widget.project],
        );
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Image.asset('assets/worker_icon.png'),
          ),
          title: Text(
            '\u{20B9} ${widget.transaction.amount.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Delete Transaction'),
                        content: const Text(
                            'Are you sure you want to delete this transaction?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No')),
                          TextButton(
                              onPressed: () {
                                Provider.of<Projects>(context, listen: false)
                                    .deleteTransaction(widget.transaction,
                                        widget.workerId, widget.project);
                                Navigator.of(context).pop();
                                setState(() {
                                  Worker temp = Provider.of<Projects>(context,
                                          listen: false)
                                      .findProject(widget.project)
                                      .workers
                                      .firstWhere((element) =>
                                          element.id == widget.workerId);
                                  Navigator.of(context).pushReplacementNamed(
                                      WorkerDetail.routeName,
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
