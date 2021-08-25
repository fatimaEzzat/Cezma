import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final myStoresStateManagment =
    ChangeNotifierProvider<MyStoresState>((ref) => MyStoresState());

class MyStoresState extends ChangeNotifier {
  List myStores = [];
  int myStoresCurrentPage = 0;
  int myStoresLastPage = 0;

  void addToStores(List input) {
    myStores.addAll(input);
    notifyListeners();
  }
}
