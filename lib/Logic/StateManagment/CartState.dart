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

  void cleanCart() {
    cart.clear();
    notifyListeners();
  }

  bool checkInCart(int id) {
    try {
      if (cart.indexWhere((element) => element["products"][0]["id"] == id) !=
          -1) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
