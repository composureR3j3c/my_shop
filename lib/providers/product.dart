import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/models/http_exceptions.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite(String? authToken, String? userId) async {
    isFavorite = !isFavorite;
    final url =
        'https://flat-chat-a738a-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json/?auth=$authToken';
    try {
      final response =
          await http.put(Uri.parse(url), body: jsonEncode(isFavorite));
      if (response.statusCode >= 400) {
        isFavorite = !isFavorite;
        notifyListeners();
        throw HttpExceptions('Could not delete Product');
      }
    } catch (e) {
      isFavorite = !isFavorite;
      throw e;
    }
    notifyListeners();
  }
}
