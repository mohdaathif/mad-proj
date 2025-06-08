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
      cardDescription: "Sports shoe from Adidas",
      longDescription:
          "Comfortable, lightweight sports shoe from Adidas combining comfort and sportiness into a single product. For real runners. (Men's category)",
      imagePath: 'assets/adidasultraboost5.jpg',
    ),
    // product 2
    Product(
      name: "Dumbbells",
      price: 20.0,
      cardDescription: "Couple of dumbbells",
      longDescription:
          "All encompassing dumbbells to suit on-the-move needs. Sold in 1kg, 2kg, 5kg, 10kg sets. (Unisex category)",
      imagePath: 'assets/dumbbells.jpg',
    ),
    // product 3
    Product(
      name: "Life F5 Treadmill",
      price: 1555.0,
      cardDescription: "Indoor medium-sized treadmill",
      longDescription:
          "Foldable, portable treadmill from Life F5 2022 collection. Can reach speeds of 20 mph, efficient electricity consumption. (Unisex category)",
      imagePath: 'assets/lifefitnessf5.jpg',
    ),
    // product 4
    Product(
      name: "Skipping Rope",
      price: 25.0,
      cardDescription: "Sports skipping rope",
      longDescription:
          "For intense workouts, made for atheletes. Special lightweight material used in manufacture lends unique and sleek feel to skipping experience, with minimal tripping. (Unisex category)",
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
