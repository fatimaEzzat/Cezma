import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:test_store/Models/LocalAppSettings.dart';
import 'package:test_store/Variables/Settings.dart';

Future<LocalAppSettings> loadLocalAppSettings() async {
  var jsonText = await rootBundle.loadString("Files/LocalSettings.json");
  Map<String, dynamic> data = json.decode(jsonText);
  var temp = LocalAppSettings.fromMap(data);
  settings = temp;
  return temp;
}
