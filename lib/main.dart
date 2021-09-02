import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/Logic/MISC/LoadLocalAppSettings.dart';
import 'package:test_store/Screens/AuthScreens/LoginScreen.dart';
import 'package:test_store/Screens/SecondaryScreens/SplashScreen.dart';
import 'Variables/Settings.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Hive.initFlutter("favorites");
  await Hive.openBox("favorites");
  var tempSettings = await loadLocalAppSettings();
  var phone = prefs.getString("phone");

  runApp(DevicePreview(
    enabled: false,
    builder: (BuildContext context) {
      return ProviderScope(
          child: GetMaterialApp(
              theme: new ThemeData(
                  scaffoldBackgroundColor: tempSettings.theme!.primary,
                  buttonColor: settings.theme!.secondary,
                  appBarTheme: AppBarTheme(
                      backgroundColor: tempSettings.theme!.primary)),
              locale: DevicePreview.locale(context), // Add the locale here
              builder: DevicePreview.appBuilder,
              home: phone == null ? LoginScreen() : CustomSplashScreen()));
    },
  ));
}
