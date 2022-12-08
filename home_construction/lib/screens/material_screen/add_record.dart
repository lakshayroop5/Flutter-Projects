import 'package:flutter/material.dart';
import 'package:home_construction/models/material.dart';
import 'package:home_construction/provider/projects.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddRecord extends StatefulWidget {
  static const routeName = '/add-record';
  const AddRecord({super.key});

  @override
  State<AddRecord> createState() => AddRecordState();
}

class AddRecordState extends State<AddRecord> {
  final _formKey = GlobalKey<FormState>();
  late Record record;
  late String materialId;
  late String project;
  String _selectedDate = '';
  // bool _isLoading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      var temp = ModalRoute.of(context)!.settings.arguments as List;
      record = temp[0] as Record;
      materialId = temp[1] as String;
      project = temp[2] as String;
      if (record.id.isNotEmpty) {
        _selectedDate = record.date.toString();
      }
      // print(transaction.amount);
      // print(transaction.description);
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
    if (record.id.isNotEmpty) {
      // print('edit');
      // print(transaction.description);
      Provider.of<Projects>(context, listen: false)
          .editRecord(record, materialId, project);
      //   .then((_) {
      // setState(() {
      //   _isLoading = false;
      // });
      Navigator.of(context).pop();
    } else {
      record = Record(
          id: DateTime.now().toString(),
          quantity: record.quantity,
          pricePerUnit: record.pricePerUnit,
          date: record.date);
      Provider.of<Projects>(context, listen: false)
          .addRecord(record, materialId, project);
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
        record = Record(
            id: record.id,
            quantity: record.quantity,
            pricePerUnit: record.pricePerUnit,
            date: value);
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
              initialValue: record.quantity == 0
                  ? ''
                  : record.quantity.toStringAsFixed(0),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Quantity',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some quantity';
                }
                return null;
              },
              onSaved: (value) {
                record = Record(
                    id: record.id,
                    quantity: double.parse(value!),
                    pricePerUnit: record.pricePerUnit,
                    date: record.date);
              },
            ),
            TextFormField(
              initialValue: record.pricePerUnit == 0
                  ? ''
                  : record.pricePerUnit.toStringAsFixed(0),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) {
                Navigator.of(context).pop();
              },
              decoration: const InputDecoration(
                labelText: 'Price of One Unit',
              ),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter some text';
              //   }
              //   return null;
              // },
              onSaved: (value) {
                record = Record(
                    id: record.id,
                    quantity: record.quantity,
                    pricePerUnit: double.parse(value!),
                    date: record.date);
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
                        'Picked Date: ${DateFormat.yMMMd().format(record.date)}'),
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
