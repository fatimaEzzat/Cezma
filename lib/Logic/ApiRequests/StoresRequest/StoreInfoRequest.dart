// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// Future requestStoreInfo(BuildContext context) async {
//   Dio dio = Dio();
//   Options requestOptions = Options(
//     responseType: ResponseType.json,
//     headers: {
//       "Content-Type": "application/json",
//       // "Authorization": userToken,
//       'Charset': 'utf-8'
//     },
//   );
//   try {
//     final response = await dio.get(
//       apiPlansUrl,
//       options: requestOptions,
//     );
//     context.read(plansStateManagment).addPlans(response.data["data"]);
//   } catch (e) {
//     Get.defaultDialog(title: "خطأ", middleText: e.toString());
//   }
// }
