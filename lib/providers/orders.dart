import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> product;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.product,
    required this.dateTime,
  });
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  final String? authToken;
  final String? userId;

  Order(this.authToken, this.userId, this._orders);

  Future<void> fetchOrders() async {
    final url =
        'https://flat-chat-a738a-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';

    try {
      final response = await http.get(Uri.parse(url));
      var _extractedData = jsonDecode(response.body) as Map<String, dynamic>?;
      if (_extractedData == null) {
        return;
      }
      List<OrderItem> loadedOrders = [];
      _extractedData.forEach((key, value) {
        loadedOrders.add(
          OrderItem(
              id: key,
              amount: value['amount'],
              dateTime: DateTime.parse(value['dateTime']),
              product: (value['product'] as List<dynamic>)
                  .map((item) => CartItem(
                        id: item['id'],
                        title: item['title'],
                        price: item['price'],
                        quantity: item['quantity'],
                      ))
                  .toList()),
        );
      });
      _orders = loadedOrders.reversed.toList();
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    final url =
        'https://flat-chat-a738a-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';

    try {
      final timestamp = DateTime.now();
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'product': cartProduct
                .map((e) => {
                      'id': e.id,
                      'price': e.price,
                      'title': e.title,
                      'quantity': e.quantity,
                    })
                .toList()
          }));
      _orders.insert(
        0,
        OrderItem(
            id: jsonDecode(response.body)['name'],
            amount: total,
            product: cartProduct,
            dateTime: timestamp),
      );
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }
}
