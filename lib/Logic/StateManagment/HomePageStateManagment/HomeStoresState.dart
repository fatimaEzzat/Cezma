import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeStoresStateManagment =
    ChangeNotifierProvider<HomeStoresState>((ref) => HomeStoresState());

class HomeStoresState extends ChangeNotifier {
  List homeStores = [];
  
  void addStores(List input) {
    homeStores.addAll(input);
    notifyListeners();
  }
}
