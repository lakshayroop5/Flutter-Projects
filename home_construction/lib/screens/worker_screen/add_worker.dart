import 'package:flutter/material.dart';
import 'package:home_construction/models/worker.dart';
import 'package:home_construction/provider/projects.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddWorker extends StatefulWidget {
  Worker worker;
  final String btnText;
  final String project;
  AddWorker(this.worker, this.btnText, this.project, {super.key});

  @override
  State<AddWorker> createState() => _AddWorkerState();
}

class _AddWorkerState extends State<AddWorker> {
  final _form = GlobalKey<FormState>();

  void _saveForm() {
    _form.currentState!.save();
    if (widget.btnText == 'Add Worker' && widget.worker.name.isNotEmpty) {
      Provider.of<Projects>(context, listen: false)
          .addWorker(widget.worker, widget.project);
      Navigator.of(context).pop();
    } else if (widget.btnText == 'Edit Worker' &&
        widget.worker.name.isNotEmpty) {
      Provider.of<Projects>(context, listen: false)
          .editWorker(widget.worker, widget.project);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              autofocus: true,
              initialValue: widget.worker.name,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: ((value) => _saveForm()),
              onSaved: (value) {
                var newWorker = Worker(
                  id: widget.worker.id,
                  name: value!,
                  totalAmount: widget.worker.totalAmount,
                  transactions: widget.worker.transactions,
                );
                widget.worker = newWorker;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(right: 20, top: 30),
              width: 150,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveForm,
                child: Text(
                  widget.btnText,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
