import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Models/UserModel.dart';

final userStateManagment =
    ChangeNotifierProvider<UserState>((ref) => UserState());

class UserState extends ChangeNotifier {
  String? userToken;
  String? userId;
  String? userPhone;
  String? userPassword;
  UserModel? userInfo;
  bool isLoggingIn = false;

  void setIsLoggingIn() {
    isLoggingIn = !isLoggingIn;
    notifyListeners();
  }

  void setUserInfo(UserModel info) {
    userInfo = info;
    notifyListeners();
  }


  void setUserId(String id) {
    userId = id;
  }
}
