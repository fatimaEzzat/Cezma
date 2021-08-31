import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:test_store/Screens/SecondaryScreens/SplashScreen.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestUserActivation(Map body) async {
  Options requestOptions = Options(
    headers: {"Content-Type": "application/json"},
  );
  Dio dio = Dio();
  try {
    print(body);
    await dio.post(apiEmailVerify, data: body, options: requestOptions);
    Get.defaultDialog(
        title: "تم",
        middleText: 'تم تفعيل حسابك بنجاح',
        onConfirm: () {
          Get.off(() => CustomSplashScreen());
        });
  } on Exception catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "خطا", middleText: e.message);
    }
  }
}
