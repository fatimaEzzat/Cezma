import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final messagesStateManagment =
    ChangeNotifierProvider<MessagesState>((ref) => MessagesState());

class MessagesState extends ChangeNotifier {
  List messages = [];
  int currentMessagesPage = 0;
  int lastMessagesPage = 0;
  void addToMessages(List input) {
    messages.addAll(input);
    notifyListeners();
  }
}
