import 'package:dio/dio.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestSignUp(Map signupInfo) async {
  Options requestOptions = Options(
    headers: {"Content-Type": "application/json"},
  );
  Dio dio = Dio();
  await dio.post(apiSignupUrl, data: signupInfo, options: requestOptions);
}
