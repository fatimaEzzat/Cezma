import 'package:dio/dio.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestUserActivation() async {
  Options requestOptions = Options(
    headers: {"Content-Type": "application/json"},
  );
  Dio dio = Dio();
  await dio.post(apiSignupUrl, data: {}, options: requestOptions);
}
