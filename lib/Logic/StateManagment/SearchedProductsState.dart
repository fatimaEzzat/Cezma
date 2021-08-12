import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchedProductsStateManagement =
    ChangeNotifierProvider<SearchedProducts>((ref) => SearchedProducts());

class SearchedProducts extends ChangeNotifier {
  List searchedProducts = [];
  int currentSearchedProductPage = 1;
  late int currentSearchedProductTotalPages;
  bool isSearching = false;

  void setIsSearching() {
    isSearching = !isSearching;
    notifyListeners();
  }

  void clearSearchedProducts() {
    searchedProducts.clear();
    notifyListeners();
  }

  void addToSearchedProducts(List input) {
    searchedProducts.addAll(input);
    notifyListeners();
  }
}
