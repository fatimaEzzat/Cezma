import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeAdsStateManagement =
    ChangeNotifierProvider<HomeAdsState>((ref) => HomeAdsState());

class HomeAdsState extends ChangeNotifier {
  List homeAds = [];

  void addAds(List input) {
    homeAds.add(input);
    notifyListeners();
  }
}
