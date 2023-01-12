import 'package:flutter/foundation.dart';

class CartItem {
  final String? itemId;
  final String? itemName;
  final int? quantity;
  final double? price;

  CartItem(
      {this.itemId,
      required this.itemName,
      required this.price,
      required this.quantity});
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> _items;

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItems(String itemId, String? itemName, int quantity, double? price) {
    if (_items.containsKey(itemId)) {
      //change quntity..
      _items.update(
          itemId,
          (existingCartItem) => CartItem(
              itemId: existingCartItem.itemId,
              itemName: existingCartItem.itemName,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity! + 1));
    } else {
      _items.putIfAbsent(
          itemId,
          () => CartItem(
              itemId: itemId,
              itemName: itemName,
              price: price,
              quantity: quantity));
    }
  }
}
