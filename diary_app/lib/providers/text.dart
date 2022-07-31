import 'package:flutter/material.dart';

class Text with ChangeNotifier {
  String? id;
  String? title;
  String? body;
  DateTime? dateTime;

  Text({this.title, this.body, this.dateTime, this.id});

  final List<Text> _textList = [
    // Text(title: 'hello', body: 'hello', dateTime: DateTime.now()),
  ];

  List<Text> get textList {
    return [..._textList];
  }
}
