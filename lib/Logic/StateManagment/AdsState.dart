import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final adsStateManagment = ChangeNotifierProvider<AdsState>((ref) => AdsState());

class AdsState extends ChangeNotifier {
  late int totalAdsPages = 0;
  late int currentAdsPage = 1;
  List ads = [];
  void addAds(List input) {
    ads.addAll(input);
    notifyListeners();
  }

  void setTotalAdsPages(int input) {
    totalAdsPages = input;
    // notifyListeners();
  }

  void setCurrentAdsPage(int input) {
    currentAdsPage = input;
  }
}
