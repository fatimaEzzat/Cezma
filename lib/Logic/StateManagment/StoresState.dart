import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final storesStateManagment =
    ChangeNotifierProvider<StoresState>((ref) => StoresState());

class StoresState extends ChangeNotifier {
  List stores = [];
  int currentStoresPage = 1;
  int lastStoresPage = 0;
  void setCurrentStoresPage(int input) {
    currentStoresPage = input;
    notifyListeners();
  }

  void setLastStoresPage(int input) {
    lastStoresPage = input;
    notifyListeners();
  }

  void addToStoresList(List input) {
    stores.addAll(input);
    notifyListeners();
  }
}
