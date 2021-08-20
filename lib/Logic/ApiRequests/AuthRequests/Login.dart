import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestLogin(Map loginInfo) async {
  Options requestOptions = Options(
    headers: {"Content-Type": "application/json"},
  );
  Dio dio = Dio();
  var response =
      await dio.post(apiLoginUrl, data: loginInfo, options: requestOptions);
  SharedPreferences.getInstance().then((value) {
    value.setString("token", response.data["token"]);
    value.setString("password", loginInfo["password"]);
    value.setString("user_id", response.data["user"]["id"].toString());
  });
}
