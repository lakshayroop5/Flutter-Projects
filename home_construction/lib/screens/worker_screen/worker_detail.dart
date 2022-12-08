import 'package:flutter/material.dart';
import 'package:home_construction/models/worker.dart';
import 'package:home_construction/provider/projects.dart';
import 'package:home_construction/screens/worker_screen/add_transaction.dart';
import 'package:home_construction/widgets/workers_screen/transaction_tile.dart';
import 'package:provider/provider.dart';

class WorkerDetail extends StatefulWidget {
  static const routeName = '/worker-detail';

  const WorkerDetail({super.key});

  @override
  State<WorkerDetail> createState() => _WorkerDetailState();
}

class _WorkerDetailState extends State<WorkerDetail> {
  late Worker worker;
  late String project;

  @override
  void didChangeDependencies() {
    var temp = ModalRoute.of(context)!.settings.arguments as List;
    worker = temp[0] as Worker;
    project = temp[1] as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final List<Transaction> list = worker.transactions;
    return Scaffold(
      appBar: AppBar(
        title: Text(worker.name),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Text(
                      'Total Amount:',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<Projects>(
                      builder: (context, value, child) => Text(
                        '\u{20B9}${worker.totalAmount.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Transactions: ${worker.transactions.length}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Consumer<Projects>(
                builder: (_, projects, child) => Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    itemBuilder: (context, i) =>
                        TransactionTile(list[i], worker.id, project),
                    itemCount: list.length,
                    shrinkWrap: true,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            right: 40,
            child: SizedBox(
              height: 65,
              width: 65,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AddTransaction.routeName,
                    arguments: [
                      Transaction(
                        id: '',
                        amount: 0,
                        date: DateTime.now(),
                        description: '',
                      ),
                      worker.id,
                      project,
                    ],
                  ).then((value) => setState(() {}));
                },
                child: const Icon(
                  Icons.add,
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
