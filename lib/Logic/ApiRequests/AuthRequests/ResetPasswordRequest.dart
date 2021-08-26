import 'package:dio/dio.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestResetPassword(Map<String, dynamic> loginInfo) async {
  Options requestOptions = Options(
    headers: {"Content-Type": "application/json"},
  );
  Dio dio = Dio();
  String temp = "+2" + loginInfo["phone"];
  Map info = {"phone": temp};
  var response =
      await dio.post(apiForgetUrl, data: info, options: requestOptions);
  return response.data;
}
