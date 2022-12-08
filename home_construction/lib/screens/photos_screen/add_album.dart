import 'package:flutter/material.dart';
import 'package:home_construction/models/album.dart';
import 'package:home_construction/provider/projects.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddAlbum extends StatefulWidget {
  Album album;
  final String btnText;
  final String project;
  AddAlbum(this.album, this.btnText, this.project, {super.key});

  @override
  State<AddAlbum> createState() => _AddAlbumState();
}

class _AddAlbumState extends State<AddAlbum> {
  final _form = GlobalKey<FormState>();

  void _saveForm() {
    _form.currentState!.save();
    if (widget.btnText == 'Add Album' && widget.album.name.isNotEmpty) {
      Provider.of<Projects>(context, listen: false)
          .addAlbum(widget.album, widget.project);
      Navigator.of(context).pop();
    } else if (widget.btnText == 'Edit Album' && widget.album.name.isNotEmpty) {
      Provider.of<Projects>(context, listen: false)
          .editAlbum(widget.album, widget.project);
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
              initialValue: widget.album.name,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: ((value) => _saveForm()),
              onSaved: (value) {
                var newAlbum = Album(
                    id: widget.album.id,
                    name: value!,
                    photos: widget.album.photos);
                widget.album = newAlbum;
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
