// ignore_for_file: depend_on_referenced_packages, prefer_final_fields
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unscript_app/chat/models/message_model.dart';
import 'package:unscript_app/chat/service/chat_service.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  final _botUser = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d2f32c');
  ChatService service = ChatService();

  getReply(String text) {
    final text1 = types.CustomMessage(
      author: _botUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      metadata: const {'message': "..."},
    );
    setState(() {
      _addMessage(text1);
    });
    service.askQuestion(context: context, requestBody: {"question": text}).then(
        (value) {
      setState(() {
        _messages.remove(text1);
        final text = types.CustomMessage(
          author: _botUser,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: randomString(),
          metadata: {'message': value['answer'], 'isBot': true},
        );
        _addMessage(text);
      });
    });
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.CustomMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      metadata: {'message': message.text, 'isBot': false},
    );
    _addMessage(textMessage);
    getReply(message.text);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        return false;
      },
      child: Scaffold(
        backgroundColor: UnScriptTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: UnScriptTheme.backgroundColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Ask Mr.Bond",
            style: UnScriptTheme.screenText(
                size: screenWidth / 12,
                color: UnScriptTheme.nearlyBlue,
                weight: FontWeight.bold),
          ),
        ),
        body: Chat(
          theme: DefaultChatTheme(
            inputContainerDecoration: BoxDecoration(
                border: Border.all(color: UnScriptTheme.bgTextColor2),
                borderRadius: BorderRadius.circular(20)),
            inputBackgroundColor: UnScriptTheme.backgroundColor,
            backgroundColor: UnScriptTheme.backgroundColor,
            inputMargin: const EdgeInsets.all(10),
            inputBorderRadius: BorderRadius.circular(20),
            attachmentButtonIcon: const Icon(
              Icons.add_a_photo,
              color: Colors.white,
            ),
          ),
          messages: _messages,
          user: _user,
          customMessageBuilder: (p0, {required messageWidth}) {
            if (p0.metadata?['message'] == "...") {
              return Container(
                padding: const EdgeInsets.all(15),
                width: 60,
                child: const SpinKitThreeBounce(
                  color: UnScriptTheme.backgroundColor,
                  size: 8,
                ),
              );
            }
            return Container(
              padding: const EdgeInsets.all(15),
              child: Text(
                p0.metadata?['message'],
              ),
            );
          },
          showUserAvatars: true,
          avatarBuilder: (userId) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                height: 40,
                child: Image.network(
                    "https://texapi.net/wp-content/uploads/2022/05/icon.png"),
              ),
            );
          },
          onSendPressed: _handleSendPressed,
        ),
      ),
    );
  }
}
