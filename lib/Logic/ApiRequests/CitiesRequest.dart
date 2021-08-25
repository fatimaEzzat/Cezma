import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestCities({required String countryName}) async {
  // our connection with the statemanagment of categories
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {"Content-Type": "application/json", 'Charset': 'utf-8'},
  );
  try {
    final response = await dio.get(
      apiCountries + "/" + countryName,
      options: requestOptions,
    );
    return response.data["data"]["county"]["cities"];
  } catch (e) {
    Get.snackbar("خطا", e.toString());
  }
}
