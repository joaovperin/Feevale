import 'package:client_app/domain/chat_message.dart';
import 'package:flutter/material.dart';

class ChatroomSingleMessageWidget extends StatelessWidget {
  const ChatroomSingleMessageWidget(this.message, {Key? key}) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Text(message.text);
  }
}
