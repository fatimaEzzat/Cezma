import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test_store/CustomWidgets/Decorations/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/ApiRequests/MessagingRequests/ChatsRequest.dart';
import 'package:test_store/Logic/ApiRequests/MessagingRequests/MessagesRequest.dart';
import 'package:test_store/Logic/ApiRequests/MessagingRequests/SendMessage.dart';
import 'package:test_store/Logic/StateManagment/ChatsState.dart';
import 'package:test_store/Logic/StateManagment/MessagesState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class ChatRoomScreen extends StatefulWidget {
  final Map chat;
  const ChatRoomScreen({Key? key, required this.chat}) : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  int userId = 0;
  final _scrollController = ScrollController();
  final _formkey = GlobalKey<FormBuilderState>();
  @override
  void initState() {
    userId = context.read(userStateManagment).userId!;
    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge) {
        final isBottom = _scrollController.position.pixels != 0;
        if (isBottom) {
          await loadData(context);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.chat["store_id"]["id"]);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: secondaryAppBar(
            context: context, title: widget.chat["store_id"]["name"]),
        body: SafeArea(
          child: FutureBuilder(
            future: requestMessages(context, 1, widget.chat["id"], true),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              List messages = context.read(messagesStateManagment).messages;
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              padding: EdgeInsets.only(
                                  left: 14, right: 14, top: 10, bottom: 10),
                              child: Align(
                                alignment:
                                    (messages[index]["customer_id"] == userId
                                        ? Alignment.topLeft
                                        : Alignment.topRight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (messages[index]["customer_id"] ==
                                            userId
                                        ? Colors.grey.shade200
                                        : Colors.blue[200]),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    messages[index]["message"],
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ));
                        },
                      ),
                    ),
                    FormBuilder(
                      key: _formkey,
                      child: ListTile(
                        trailing: Container(
                          width: screenWidth(context) * 0.8,
                          child: FormBuilderTextField(
                            name: "message",
                            decoration: customformfielddecoration(
                                context: context, color: Colors.grey.shade300),
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: violet,
                          child: IconButton(
                              onPressed: () async {
                                await sendMessage();
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  color: violet,
                ));
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> sendMessage() async {
    if (_formkey.currentState!.fields["message"]!.value != null) {
      await requestNewMessage(context, widget.chat["store_id"]["id"],
          _formkey.currentState!.fields["message"]!.value);
    }
  }

  Future<void> loadData(BuildContext context) async {
    print(context.read(chatsStateManagment).lastChatsPage);
    if (context.read(chatsStateManagment).currentChatsPage <=
        context.read(chatsStateManagment).lastChatsPage) {
      print(context.read(chatsStateManagment).lastChatsPage);
      print("sss");
      await requestChats(
          context, context.read(chatsStateManagment).currentChatsPage, false);
    }
  }
}
