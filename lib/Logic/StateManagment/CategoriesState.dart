import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final categoriesStateManagment =
    ChangeNotifierProvider<CategoriesState>((ref) => CategoriesState());

class CategoriesState extends ChangeNotifier {
  List categories = [];
  List allCategories = [];
  String? selectedCategory;
  bool isLoadingNewCategories = false;
  bool isLoadingSubCategories = false;
  List subCategoriesProducts = [];

  void addSubCategoriesProducts(List input, List allCategories) {
    subCategoriesProducts.addAll(input);
    allCategories.addAll(allCategories);
    notifyListeners();
  }

  void setIsLoadingSubCategories() {
    isLoadingSubCategories = !isLoadingSubCategories;
    notifyListeners();
  }

  void setCategoriesLoadingState() {
    isLoadingNewCategories = !isLoadingNewCategories;
    notifyListeners();
  }

  void setSelectedCategory(String input) {
    selectedCategory = input;
    notifyListeners();
  }
}
