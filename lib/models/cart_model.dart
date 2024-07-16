import 'package:flutter/material.dart';
import 'product.dart';

class CartModel {
  static ValueNotifier<int> cartItemCount = ValueNotifier<int>(0);
  static List<Product> cartItems = [];

  static void addItem(Product product) {
    cartItems.add(product);
    cartItemCount.value = cartItems.length;
  }

  static void removeItem(Product product) {
    cartItems.remove(product);
    cartItemCount.value = cartItems.length;
  }

  static void clearCart() {
    cartItems.clear();
    cartItemCount.value = cartItems.length;
  }
}
