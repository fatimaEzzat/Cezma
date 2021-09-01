import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeStateManagment =
    ChangeNotifierProvider<HomeState>((ref) => HomeState());

class HomeState extends ChangeNotifier {
  List homeAds = [];
  List homeSliders = [];
  List homeProducts = [];
  List homeStores = [];

  void getHomeData(Map input) {
    homeAds = input["data"]["ad"];
    homeSliders = input["data"]["sliders"];
    homeProducts = input["data"]["products"];
    homeStores = input["data"]['stores'];
    notifyListeners();
  }

  void clearHomeData() {
    homeAds.clear();
    homeSliders.clear();
    homeProducts.clear();
    homeStores.clear();
  }
}
