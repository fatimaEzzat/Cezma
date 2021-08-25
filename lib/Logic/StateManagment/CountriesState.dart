import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:test_store/Logic/StateManagment/StateManagement.dart';

final countriesStateManagment =
    ChangeNotifierProvider<CountriesState>((ref) => CountriesState());

class CountriesState extends ChangeNotifier {
  List countries = [];
  List governorates = [];
  List cities = [];
  var selectedGov;

  void setCountries(List input) {
    countries = input;
  }

  void setSelectedGov(var input) {
    selectedGov = input;
    notifyListeners();
  }


}
