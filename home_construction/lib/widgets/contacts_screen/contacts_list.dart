import 'package:flutter/material.dart';
import 'package:home_construction/models/contact.dart';
import 'package:home_construction/screens/contacts_screen/add_contact.dart';

import '../add_button.dart';
import 'contacts_tile.dart';

class ContactsList extends StatelessWidget {
  final List<Contact> list;
  final String project;
  const ContactsList(this.list, this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 5,
          ),
          itemBuilder: (context, i) => ContactsTile(list[i], project),
          itemCount: list.length,
        ),
        AddButton(
          AddContact(
              Contact(id: '', name: '', number: ''), 'Add Contact', project),
          project,
        ),
      ],
    );
  }
}
