import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cartStateManagment =
    ChangeNotifierProvider<CartState>((ref) => CartState());

class CartState extends ChangeNotifier {
  List cart = [];
  double cartTotalPayment = 0;
  int currentCartPage = 0;
  int lastCartPage = 0;
  void addToCart(List input) {
    cart.addAll(input);
    notifyListeners();
  }

  void setCartTotalPayment(double amount) {
    cartTotalPayment = amount;
    notifyListeners();
  }

  // void deleteFromCart(int index) {
  //   cart.deleteItemFromCart(index);
  //   notifyListeners();
  // }

  // void incrementProduct(int index) {
  //   cart.incrementItemToCart(index);
  //   notifyListeners();
  // }

  // void decrementProduct(int index) {
  //   cart.decrementItemFromCart(index);
  //   notifyListeners();
  // }
}
