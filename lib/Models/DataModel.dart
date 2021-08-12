class ResponseModel {
  String success;
  String message;
  Map<String, dynamic> data;
  ResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });
}
