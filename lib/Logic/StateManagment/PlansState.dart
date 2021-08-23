import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final plansStateManagment =
    ChangeNotifierProvider<PlansState>((ref) => PlansState());

class PlansState extends ChangeNotifier {
  List plans = [];
  void addPlans(List input) {
    plans.addAll(input);
  }
}
