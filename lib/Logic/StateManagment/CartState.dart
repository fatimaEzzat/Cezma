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

  void removeItemFromCart(int itemId) {
    cart.removeWhere((element) => element["id"] == itemId);
    notifyListeners();
  }

  void addItemToCart(Map item) {
    cart.add({
      "products": [item]
    });
    notifyListeners();
  }

  getIdFromCart(int id) {
    return cart
        .firstWhere((element) => element["products"][0]["id"] == id)["id"];
  }

  void changeQNT(int itemId, int qnt) {
    Map item = cart.firstWhere((element) => element["id"] == itemId);
    item.update("qnt", (value) => qnt);
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
