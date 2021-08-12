import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Models/LocalAppSettings.dart';

final localAppSettingsStateManagment =
    ChangeNotifierProvider<LocalAppSettingsState>(
        (ref) => LocalAppSettingsState());

class LocalAppSettingsState extends ChangeNotifier {
  late LocalAppSettings settings;

  void setLocalAppSettings(LocalAppSettings input) {
    settings = input;
  }
}
