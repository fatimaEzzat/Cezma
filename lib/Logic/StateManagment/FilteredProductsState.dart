import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final filteredProductsStateManagment =
    ChangeNotifierProvider<FilteredProductsState>(
        (ref) => FilteredProductsState());

class FilteredProductsState extends ChangeNotifier {
  int totalFilteredCategoriesPages = 1;
  int currentFilteredCategoryPage = 1;
  List filteredProducts = [];
  bool isLoadingFilteredProducts = false;

  void addToFilteredProducts(List input) {
    filteredProducts.addAll(input);
    notifyListeners();
  }

  void setLoadingFilteredProductsState() {
    isLoadingFilteredProducts = !isLoadingFilteredProducts;
    notifyListeners();
  }
}
