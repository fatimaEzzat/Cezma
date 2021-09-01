import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchedItemsStateManagement =
    ChangeNotifierProvider<SearchedItems>((ref) => SearchedItems());

class SearchedItems extends ChangeNotifier {
  Map searchedItems = {};
  int currentSearchedItemPage = 1;
  late int currentSearchedItemTotalPages;
  bool isSearching = false;

  void setIsSearching() {
    isSearching = !isSearching;
    notifyListeners();
  }

  void clearSearchedItems() {
    searchedItems.clear();
    notifyListeners();
  }

  void addToSearchedItems(Map input) {
    searchedItems = input;
    notifyListeners();
  }
}
