import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final locationStateManagment =
    ChangeNotifierProvider<Locations>((ref) => Locations());

class Locations extends ChangeNotifier {
  bool isGettingLocation = false;
  
  void setIsGettingLocation() {
    isGettingLocation = !isGettingLocation;
    notifyListeners();
  }
}
