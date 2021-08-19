import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeProductsStateManagment =
    ChangeNotifierProvider<HomeProductsState>((ref) => HomeProductsState());

class HomeProductsState extends ChangeNotifier {
  List homeProducts = [];
  
  void addProducts(List input) {
    homeProducts.addAll(input);
  }
}
