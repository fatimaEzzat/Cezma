import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:test_store/Logic/StateManagment/CountriesState.dart';

Future<void> readCitiesJson(BuildContext context) async {
  final String citiesResponse =
      await rootBundle.loadString('Files/cities.json');
  final String governatesResponse =
      await rootBundle.loadString("Files/governorates.json");
  final cities = await json.decode(citiesResponse);
  final governates = await json.decode(governatesResponse);
  context
      .read(countriesStateManagment)
      .setCitiesandGovernates(cities[2]["data"], governates[2]["data"]);
}
