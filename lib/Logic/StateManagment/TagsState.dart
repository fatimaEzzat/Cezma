import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tagsStateManagment =
    ChangeNotifierProvider<TagsState>((ref) => TagsState());

class TagsState extends ChangeNotifier {
  List tags = [];
  int tagsCurrentPage = 0;
  int tagsLastPage = 0;
  void addTagsToList(List input) {
    tags.addAll(input);
    notifyListeners();
  }
}
