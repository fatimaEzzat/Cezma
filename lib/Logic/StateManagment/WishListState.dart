import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final wishListtateManagment =
    ChangeNotifierProvider<WishListState>((ref) => WishListState());

class WishListState extends ChangeNotifier {
  List wishList = [];
  int currentWishListPage = 0;
  int lastWishListPage = 0;

  addToWishList(List inputs) async {
    wishList.addAll(inputs);
    notifyListeners();
  }

  cleanWishList() {
    wishList.clear();
    notifyListeners();
  }

  bool checkInWishList(int id) {
    try {
      if (wishList
              .indexWhere((element) => element["products"][0]["id"] == id) !=
          -1) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

   getIdFromWishList(int id) {
   return wishList.firstWhere((element) => element["products"][0]["id"]==id)["id"];
  }
}
