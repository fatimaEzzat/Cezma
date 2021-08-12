import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final controllerStateManagment =
    ChangeNotifierProvider<ControllerState>((ref) => ControllerState());

class ControllerState extends ChangeNotifier {
  late TabController conroller;
  
  void setTabControllerLength(int length)
  {
    
  }
}
