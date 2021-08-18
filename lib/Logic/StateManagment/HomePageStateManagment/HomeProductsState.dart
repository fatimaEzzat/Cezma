import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Screens/NavBarScreens/HomeScreen.dart';

final homeProductsStateManagment =
    ChangeNotifierProvider<HomeProductsState>((ref) => HomeProductsState());

class HomeProductsState extends ChangeNotifier {
  List homeProducts = [];
  
}
