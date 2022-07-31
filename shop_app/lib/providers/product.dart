import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/http_exception.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavourite = false,
  });

  void _setFavStatus(bool isFav) {
    isFavourite = isFav;
    notifyListeners();
  }

  Future<void> toggleFavourite(String token, String userId) async {
    final url = Uri.parse(
        'https://shop-app-482af-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json?auth=$token');
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    try {
      final response = await http.put(url,
          body: json.encode(
            isFavourite,
          ));
      if (response.statusCode >= 400) {
        _setFavStatus(oldStatus);
        throw HttpExceptions("Couldn't perform");
      }
    } catch (error) {
      _setFavStatus(oldStatus);
      throw error;
    }
  }
}
