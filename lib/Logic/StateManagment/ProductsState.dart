import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final productsStateManagment =
    ChangeNotifierProvider<ProductsState>((ref) => ProductsState());

class ProductsState extends ChangeNotifier {
  int currentProductPage = 1;
  int totalProductsPages = 0;
  List products = [];
  bool isLoadingNewItems = false;
  List productRates = [];
  void putRates(List info) {
    productRates = info;
    notifyListeners();
  }

  void clearRates() {
    productRates.clear();
    notifyListeners();
  }

  void setIsLoadingNewItems() {
    isLoadingNewItems = !isLoadingNewItems;
    notifyListeners();
  }

  void addproducts(List input) {
    products.addAll(input);
    notifyListeners();
  }

  void setcurrentpages(int cpage) {
    currentProductPage = cpage;
    notifyListeners();
  }

  void setTotalProductsPages(int tpage) {
    totalProductsPages = tpage;
    notifyListeners();
  }
}
