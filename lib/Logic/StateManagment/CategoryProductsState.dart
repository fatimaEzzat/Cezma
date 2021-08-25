import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final categoryProductsStateManagment =
    ChangeNotifierProvider<FilteredProductsState>(
        (ref) => FilteredProductsState());

class FilteredProductsState extends ChangeNotifier {
  int totalCategoryProductsPages = 1;
  int currentCategoryProductsPage = 1;
  List categoryProducts = [];
  bool isLoadingFilteredProducts = false;

  void addCategoryProducts(List input) {
    categoryProducts.addAll(input);
    notifyListeners();
  }

  void setLoadingFilteredProductsState() {
    isLoadingFilteredProducts = !isLoadingFilteredProducts;
    notifyListeners();
  }
}
