import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/project.dart';
import '../../provider/projects.dart';

class AddProject extends StatefulWidget {
  final String btnText;
  Project project;
  AddProject(this.btnText, this.project, {super.key});

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final _form = GlobalKey<FormState>();

  void _saveForm() async {
    _form.currentState!.save();
    if (widget.btnText == 'Add Project' && widget.project.name.isNotEmpty) {
      await Provider.of<Projects>(context, listen: false)
          .addProject(widget.project.name);

      Navigator.of(context).pop();
    }
    // } else if (widget.btnText == 'Edit Project' &&
    //     widget.project.name.isNotEmpty) {
    //   Provider.of<Projects>(context, listen: false)
    //       .editProject(widget.project.name);
    //   Navigator.of(context).pop();
    //   Navigator.of(context).pop();
    // }
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
              initialValue: widget.project.name,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: ((value) => _saveForm()),
              onSaved: (value) {
                var newProject = Project(
                  name: value!,
                  albums: widget.project.albums,
                  workers: widget.project.workers,
                  contacts: widget.project.contacts,
                  materials: widget.project.materials,
                );
                widget.project = newProject;
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
