import 'dart:convert';

class WishListResponseModel {
  String success;
  String message;
  Map<String, dynamic> data;
  WishListResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }

  factory WishListResponseModel.fromMap(Map<String, dynamic> map) {
    return WishListResponseModel(
      success: map['success'],
      message: map['message'],
      data: Map<String, dynamic>.from(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WishListResponseModel.fromJson(String source) =>
      WishListResponseModel.fromMap(json.decode(source));
}
