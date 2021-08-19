import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeSlidersStateManagment =
    ChangeNotifierProvider<HomeSlidersState>((ref) => HomeSlidersState());

class HomeSlidersState extends ChangeNotifier {
  List homeSliders = [];

  void addSliders(List input) {
    homeSliders.addAll(input);
    notifyListeners();
  }
}
