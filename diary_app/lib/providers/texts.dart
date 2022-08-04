import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './text.dart' as txt;

class Texts with ChangeNotifier {
  List<txt.Text> _textList = [
    // Text(title: 'hello', body: 'hello', dateTime: DateTime.now()),
  ];

  List<txt.Text> get textList {
    return [..._textList];
  }

  txt.Text findTextById(String id) {
    return _textList.firstWhere((element) => element.id == id);
  }

  Future<void> fetchData() async {
    final url =
        Uri.parse('https://jklf-aa08d-default-rtdb.firebaseio.com/texts.json');

    final response = await http.get(url);
    final fetchedData = json.decode(response.body) as Map<String, dynamic>;
    // print(fetchedData);
    List<txt.Text> loadedTexts = [];
    fetchedData.forEach((textId, textData) {
      loadedTexts.add(txt.Text(
        id: textId,
        title: textData['title'],
        body: textData['body'],
        dateTime: DateTime.parse(textData['dateTime']),
      ));
    });
    _textList = loadedTexts;
  }

  Future<void> addText(txt.Text newText) async {
    final url =
        Uri.parse('https://jklf-aa08d-default-rtdb.firebaseio.com/texts.json');
    try {
      final timestamp = newText.dateTime;
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': newText.title,
            'body': newText.body,
            'dateTime': timestamp!.toIso8601String(),
          },
        ),
      );
      final newtext = txt.Text(
        title: newText.title,
        body: newText.body,
        dateTime: timestamp,
        id: json.decode(response.body)['name'],
      );
      _textList.add(newtext);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateText(txt.Text newText) async {
    final url = Uri.parse(
        'https://jklf-aa08d-default-rtdb.firebaseio.com/texts/${newText.id}.json');
    final timeStamp = newText.dateTime!.toIso8601String();
    await http.patch(url,
        body: json.encode({
          'title': newText.title,
          'body': newText.body,
          'dateTime': timeStamp,
        }));
    final prodIndex =
        _textList.indexWhere((element) => element.id == newText.id);

    _textList[prodIndex] = newText;
    notifyListeners();
  }

  Future<void> deleteText(String id) async {
    final url = Uri.parse(
        'https://jklf-aa08d-default-rtdb.firebaseio.com/texts/$id.json');
    await http.delete(url);
    _textList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
