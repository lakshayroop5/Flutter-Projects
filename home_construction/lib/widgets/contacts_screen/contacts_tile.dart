import 'package:flutter/material.dart';
import 'package:home_construction/models/contact.dart';
import 'package:home_construction/provider/projects.dart';
import 'package:home_construction/screens/contacts_screen/add_contact.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ContactsTile extends StatelessWidget {
  final Contact contact;
  final String project;
  const ContactsTile(this.contact, this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await FlutterPhoneDirectCaller.callNumber(contact.number);
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Image.asset('assets/contact_icon.png',
                width: 39, height: 39, fit: BoxFit.cover),
          ),
          title: Text(
            contact.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(contact.number),
          trailing: PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) =>
                          AddContact(contact, 'Edit Contact', project),
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
                        builder: (_) => AlertDialog(
                              title: const Text('Delete Contact'),
                              content: const Text(
                                  'Do you want to delete this contact?'),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('No')),
                                TextButton(
                                    onPressed: () {
                                      Provider.of<Projects>(context,
                                              listen: false)
                                          .deleteContact(contact, project);
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
        ),
      ),
    );
  }
}
