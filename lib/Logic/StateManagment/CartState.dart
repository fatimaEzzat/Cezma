import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cartStateManagment =
    ChangeNotifierProvider<CartState>((ref) => CartState());

class CartState extends ChangeNotifier {
  var cart = FlutterCart();

  bool checkItemInCart(String id) {
    if (cart.getSpecificItemFromCart(id) != null) {
      return true;
    } else {
      return false;
    }
  }

  void clearCart() {
    cart.deleteAllCart();
  }

  void addOrRemovefromCart(
      String id, int price, String productName, String image, List options) {
    if (cart.getSpecificItemFromCart(id) != null) {
      cart.deleteItemFromCart(cart.findItemIndexFromCart(id)!);
    } else {
      cart.addToCart(
          uniqueCheck: image,
          productId: id,
          unitPrice: price,
          productName: productName,
          quantity: 1,
          productDetailsObject: options);
    }
    notifyListeners();
  }

  void deleteFromCart(int index) {
    cart.deleteItemFromCart(index);
    notifyListeners();
  }

  void incrementProduct(int index) {
    cart.incrementItemToCart(index);
    notifyListeners();
  }

  void decrementProduct(int index) {
    cart.decrementItemFromCart(index);
    notifyListeners();
  }
}
