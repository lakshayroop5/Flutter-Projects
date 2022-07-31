import 'package:flutter/material.dart';
import 'package:jkl/providers/texts.dart';
import 'package:provider/provider.dart';
import '../providers/text.dart' as text;
import 'package:intl/intl.dart';

class TextUploadScreen extends StatefulWidget {
  static const routeName = '/Text-upload-screen';
  const TextUploadScreen({Key? key}) : super(key: key);

  @override
  State<TextUploadScreen> createState() => _TextUploadScreenState();
}

class _TextUploadScreenState extends State<TextUploadScreen> {
  final _form = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? textId;
  bool _init = true;
  var _initialText =
      text.Text(title: '', body: '', dateTime: DateTime.now(), id: null);
  var _newText =
      text.Text(title: '', body: '', dateTime: DateTime.now(), id: null);

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    if (_init) {
      textId = ModalRoute.of(context)!.settings.arguments as String?;
    }
    if (textId != null) {
      _newText =
          Provider.of<Texts>(context, listen: false).findTextById(textId!);
      _selectedDate = _newText.dateTime;
    }
    _initialText = text.Text(
      id: _newText.id,
      title: _newText.title,
      body: _newText.body,
      dateTime: _newText.dateTime,
    );

    _init = false;

    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    // print('1');
    // final isValid = _form.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    // print('2');
    _form.currentState!.save();
    if (textId != null) {
      Provider.of<Texts>(context, listen: false).updateText(_newText);
      Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Texts>(context, listen: false).addText(_newText);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Error!'),
            content: const Text('Something went wrong!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Okay'))
            ],
          ),
        );
      }
      // ignore: use_build_context_synchronously
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
        _selectedDate = value;
        _newText = text.Text(
            title: _newText.title,
            body: _newText.body,
            dateTime: value,
            id: _newText.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memories'),
        actions: [
          TextButton(
            onPressed: _presentDatePicker,
            child: Text(
              // ignore: unnecessary_null_comparison
              _selectedDate == null
                  ? 'Choose Date'
                  : DateFormat.yMMMd().format(_selectedDate!),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.015,
                  horizontal: MediaQuery.of(context).size.height * 0.015),
              child: TextFormField(
                initialValue: _initialText.title,
                textInputAction: TextInputAction.next,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 30),
                decoration: const InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(fontSize: 30),
                ),
                validator: (value) {
                  if (value != null) {
                    return value;
                  }
                  return null;
                },
                onSaved: (value) {
                  _newText = text.Text(
                      id: _newText.id,
                      title: value!,
                      body: _newText.body,
                      dateTime: _newText.dateTime);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.015),
              child: TextFormField(
                initialValue: _initialText.body,
                maxLines: null,
                minLines: 30,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  hintText: 'Body',
                  hintStyle: TextStyle(fontSize: 18),
                ),
                validator: (value) {
                  if (value != null) {
                    return value;
                  }
                  return null;
                },
                onSaved: (value) {
                  _newText = text.Text(
                      id: _newText.id,
                      title: _newText.title,
                      body: value!,
                      dateTime: _newText.dateTime);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
