import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatsStateManagment =
    ChangeNotifierProvider<ChatsState>((ref) => ChatsState());

class ChatsState extends ChangeNotifier {
  List chats = [];
  int lastChatsPage = 0;
  int currentChatsPage = 0;
  void addToChats(List input) {
    chats.addAll(input);
    notifyListeners();
  }
}
