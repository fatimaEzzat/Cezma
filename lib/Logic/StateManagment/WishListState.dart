import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final wishListtateManagment =
    ChangeNotifierProvider<WishListState>((ref) => WishListState());

class WishListState extends ChangeNotifier {
  List wishList = [];
  var box = Hive.box('favorites');

  addToWishList(var value, int key) async {
    if (box.containsKey(key)) {
      box.delete(key);
    } else {
      box.put(key, value);
    }
    notifyListeners();
  }

  removeItemFromWishList(var id) {
    box.delete(id);
    notifyListeners();
  }
}
