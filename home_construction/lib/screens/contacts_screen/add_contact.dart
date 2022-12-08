import 'package:flutter/material.dart';
import 'package:home_construction/models/contact.dart';
import 'package:home_construction/provider/projects.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddContact extends StatefulWidget {
  Contact contact;
  final String btnText;
  final String project;
  AddContact(this.contact, this.btnText, this.project, {super.key});

  @override
  State<AddContact> createState() => AddContactState();
}

class AddContactState extends State<AddContact> {
  final _form = GlobalKey<FormState>();

  void _saveForm() {
    _form.currentState!.save();
    if (widget.btnText == 'Add Contact' && widget.contact.name.isNotEmpty) {
      Provider.of<Projects>(context, listen: false)
          .addContact(widget.contact, widget.project);
      Navigator.of(context).pop();
    } else if (widget.btnText == 'Edit Contact' &&
        widget.contact.name.isNotEmpty) {
      Provider.of<Projects>(context, listen: false)
          .editContact(widget.contact, widget.project);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            autofocus: true,
            initialValue: widget.contact.name,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: ((value) => _saveForm()),
            onSaved: (value) {
              var newContact = Contact(
                id: widget.contact.id,
                name: value!,
                number: widget.contact.number,
              );
              widget.contact = newContact;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          TextFormField(
            autofocus: true,
            initialValue: widget.contact.number,
            decoration: const InputDecoration(
              labelText: 'Number',
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: ((value) => _saveForm()),
            onSaved: (value) {
              var newContact = Contact(
                id: widget.contact.id,
                name: widget.contact.name,
                number: value!,
              );
              widget.contact = newContact;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a numer';
              }
              return null;
            },
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
