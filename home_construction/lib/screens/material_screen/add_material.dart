import 'package:flutter/material.dart';
import 'package:home_construction/models/material.dart';
import 'package:home_construction/provider/projects.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddMaterial extends StatefulWidget {
  MaterialItem material;
  final String btnText;
  final String project;
  AddMaterial(this.material, this.btnText, this.project, {super.key});

  @override
  State<AddMaterial> createState() => AddMaterialState();
}

class AddMaterialState extends State<AddMaterial> {
  final _form = GlobalKey<FormState>();

  void _saveForm() {
    _form.currentState!.save();
    if (widget.btnText == 'Add Material' && widget.material.name.isNotEmpty) {
      Provider.of<Projects>(context, listen: false)
          .addMaterial(widget.material, widget.project);
      Navigator.of(context).pop();
    } else if (widget.btnText == 'Edit Material' &&
        widget.material.name.isNotEmpty) {
      Provider.of<Projects>(context, listen: false)
          .editMaterial(widget.material, widget.project);
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
            initialValue: widget.material.name,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            onSaved: (value) {
              var newMaterial = MaterialItem(
                id: widget.material.id,
                name: value!,
                total: widget.material.total,
                quantity: widget.material.quantity,
                unit: widget.material.unit,
                records: widget.material.records,
              );
              widget.material = newMaterial;
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
            initialValue: widget.material.unit,
            decoration: const InputDecoration(
              labelText: 'Unit',
            ),
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: ((value) => _saveForm()),
            onSaved: (value) {
              var newMaterial = MaterialItem(
                id: widget.material.id,
                name: widget.material.name,
                total: widget.material.total,
                quantity: widget.material.quantity,
                unit: value!,
                records: widget.material.records,
              );
              widget.material = newMaterial;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a unit';
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
