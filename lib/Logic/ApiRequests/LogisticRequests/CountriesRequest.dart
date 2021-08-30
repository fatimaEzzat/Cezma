import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_store/Logic/StateManagment/CountriesState.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future requestShowCountry(String? userToken, BuildContext context) async {
  final Map<String, String?> data = {
    'name': "مصر",
  };
  Options requestOptions = Options(
    headers: {"Content-Type": "application/json", "Authorization": userToken},
  );
  Dio dio = Dio();
  var response =
      await dio.post(apiShowCountryUrl, data: data, options: requestOptions);
  context.read(countriesStateManagment).setCountries(response.data[0]["govs"]);
  return response.data;
}
