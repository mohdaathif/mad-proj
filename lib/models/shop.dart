import 'package:flutter/material.dart';
import 'package:mad_proj/models/product.dart';

class Shop extends ChangeNotifier {
  // extends change notifier enables shop to use change notifier
  // list of products for sale
  final List<Product> _shop = [
    // product 1
    Product(
      name: "Adidas Ultra Boost 5",
      price: 85.0,
      description: "Item Description",
      imagePath: 'assets/adidasultraboost5.jpg',
    ),
    // product 2
    Product(
      name: "Dumbbells",
      price: 20.0,
      description: "Item Description",
      imagePath: 'assets/dumbbells.jpg',
    ),
    // product 3
    Product(
      name: "Life F5 Treadmill",
      price: 1555.0,
      description: "Item Description",
      imagePath: 'assets/lifefitnessf5.jpg',
    ),
    // product 4
    Product(
      name: "Skipping Rope",
      price: 25.0,
      description: "Item Description",
      imagePath: 'assets/skippingrope.jpg',
    ),
  ];

  // list for user's cart
  List<Product> _cart = [];

  // get product list
  List<Product> get shop => _shop;

  // get user cart
  List<Product> get cart => _cart;

  // add item to cart
  void addToCart(Product item) {
    _cart.add(item);
    notifyListeners(); // update UI for components listening to these changes
  }

  // remove item from cart
  void removeFromCart(Product item) {
    _cart.remove(item);
    notifyListeners(); // update UI for components listening to these changes
  }
}
