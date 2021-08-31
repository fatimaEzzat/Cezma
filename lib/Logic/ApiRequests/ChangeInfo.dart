import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_store/Logic/ApiRequests/ProfileRequests/UserInfoRequest.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestChangeInfo(
    String? _userToken, Map changeInfoData, BuildContext context) async {
  Options requestOptions = Options(
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _userToken!
    },
  );
  Dio dio = Dio();
  await dio.post(apiEditProfileUrl + "/edit",
      data: changeInfoData, options: requestOptions);
  await requestUserInfo(_userToken, context);
}
