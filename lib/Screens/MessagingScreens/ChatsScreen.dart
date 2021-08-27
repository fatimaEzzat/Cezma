import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/Logic/ApiRequests/MessagingRequests/ChatsRequest.dart';
import 'package:test_store/Logic/StateManagment/ChatsState.dart';
import 'package:test_store/Screens/MessagingScreens/ChatRoomScreen.dart';
import 'package:test_store/Variables/CustomColors.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: secondaryAppBar(
              context: context,
              title: "الرسايل",
              secondary: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onSecondaryPressed: () {
                requestChats(context, 1, true);
              }),
          body: Consumer(
            builder: (BuildContext context,
                    T Function<T>(ProviderBase<Object?, T>) watch,
                    Widget? child) =>
                ListView.builder(
              itemCount: watch(chatsStateManagment).chats.length,
              itemBuilder: (BuildContext context, int index) {
                final chatItem = watch(chatsStateManagment).chats[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      Get.to(() => ChatRoomScreen(
                            chat: chatItem,
                          ));
                    },
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: violet,
                    ),
                    leading: CircleAvatar(
                        backgroundColor: violet,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        )),
                    title: Text(chatItem["store_id"]["name"]),
                  ),
                );
              },
            ),
          )),
    );
  }
}
