import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final categoriesStateManagment =
    ChangeNotifierProvider<CategoriesState>((ref) => CategoriesState());

class CategoriesState extends ChangeNotifier {
  List categories = [];
  String? selectedCategory;
  bool isLoadingNewCategories = false;
  bool isLoadingSubCategories = false;
  List subCategories = [];

  void addSubCategories(List input) {
    subCategories = input;
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
