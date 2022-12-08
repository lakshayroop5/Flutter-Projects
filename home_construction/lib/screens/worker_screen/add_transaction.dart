import 'package:flutter/material.dart';
import 'package:home_construction/models/worker.dart';
import 'package:home_construction/provider/projects.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTransaction extends StatefulWidget {
  static const routeName = '/add-transaction';
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _formKey = GlobalKey<FormState>();
  late Transaction transaction;
  late String workerId;
  late String project;
  String _selectedDate = '';
  // bool _isLoading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      var temp = ModalRoute.of(context)!.settings.arguments as List;
      transaction = temp[0] as Transaction;
      workerId = temp[1] as String;
      project = temp[2] as String;
      if (transaction.id.isNotEmpty) {
        _selectedDate = transaction.date.toString();
      }
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    // setState(() {
    //   _isLoading = true;
    // });
    if (transaction.id.isNotEmpty) {
      Provider.of<Projects>(context, listen: false)
          .editTransaction(transaction, workerId, project);
      //   .then((_) {
      // setState(() {
      //   _isLoading = false;
      // });
      Navigator.of(context).pop();
    } else {
      transaction = Transaction(
        id: DateTime.now().toString(),
        amount: transaction.amount,
        date: transaction.date,
        description: transaction.description,
      );
      Provider.of<Projects>(context, listen: false)
          .addTransaction(transaction, workerId, project);
      //   .then((_) {
      // setState(() {
      //   _isLoading = false;
      // });
      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then(
      (value) {
        if (value == null) {
          return;
        }
        setState(() {
          _selectedDate = value.toString();
        });
        transaction = Transaction(
          id: transaction.id,
          amount: transaction.amount,
          date: value,
          description: transaction.description,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Processing Data'),
                  ),
                );
              }
              _saveForm();
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            TextFormField(
              autofocus: true,
              initialValue: transaction.amount == 0
                  ? ''
                  : transaction.amount.toStringAsFixed(0),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                transaction = Transaction(
                  id: transaction.id,
                  amount: double.parse(value!),
                  date: transaction.date,
                  description: transaction.description,
                );
              },
            ),
            TextFormField(
              initialValue: transaction.description,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) {
                Navigator.of(context).pop();
              },
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter some text';
              //   }
              //   return null;
              // },
              onSaved: (value) {
                transaction = Transaction(
                  id: transaction.id,
                  amount: transaction.amount,
                  date: transaction.date,
                  description: value!,
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _selectedDate.toString().isEmpty
                    ? const Text('No Date Chosen')
                    : Text(
                        'Picked Date: ${DateFormat.yMMMd().format(transaction.date)}'),
                ElevatedButton(
                  onPressed: _presentDatePicker,
                  child: const Text('Choose Date'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
