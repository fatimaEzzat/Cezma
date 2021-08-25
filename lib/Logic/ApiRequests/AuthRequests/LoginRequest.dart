import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestLogin(Map<String, dynamic> loginInfo) async {
  Options requestOptions = Options(
    headers: {"Content-Type": "application/json"},
  );
  Dio dio = Dio();
  String temp = "+2" + loginInfo["user"];
  Map info = {"user": temp, "password": loginInfo["password"]};
  var response =
      await dio.post(apiLoginUrl, data: info, options: requestOptions);
  SharedPreferences.getInstance().then((sharedValue) {
    sharedValue.setString("token", response.data["data"]["token"]);
  });
  return response.data;
}
