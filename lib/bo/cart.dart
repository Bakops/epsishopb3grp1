import 'package:flutter/material.dart';

import 'product.dart';

class Cart with ChangeNotifier {
  final List<Product> _items = [];

  List<Product> getAll() {
    return List.unmodifiable(_items);
  }

  void addItem(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeItem(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  int getItemCount() {
    return _items.length;
  }

  double getTotal() {
    return _items.fold(0, (total, item) => total + item.price);
  }
}
