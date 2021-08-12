import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final categoriesStateManagment =
    ChangeNotifierProvider<CategoriesState>((ref) => CategoriesState());

class CategoriesState extends ChangeNotifier {
  int currentCategoryPage = 1;
  int totalCategoryPages = 0;
  List categories = [];
  String? selectedCategory;
  bool isLoadingNewCategories = false;

  void setCategoriesLoadingState() {
    isLoadingNewCategories = !isLoadingNewCategories;
    notifyListeners();
  }

  void setSelectedCategory(String input) {
    selectedCategory = input;
    notifyListeners();
  }

  void setCurrentCategoryPage(int input) {
    currentCategoryPage = input;
  }

  void addcategories(List input) {
    categories.addAll(input);
    notifyListeners();
  }

  void setTotalCategoryPages(int totalPages) {
    totalCategoryPages = totalPages;
  }
}
