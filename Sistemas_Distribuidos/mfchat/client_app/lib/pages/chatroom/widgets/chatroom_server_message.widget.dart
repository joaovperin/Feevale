import 'package:client_app/domain/app_chat.dart';
import 'package:flutter/material.dart';

class ChatroomServerMessageWidget extends StatelessWidget {
  const ChatroomServerMessageWidget(this.message, {Key? key}) : super(key: key);

  final AppServerMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withAlpha(30), width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    text: '${message.icon} ',
                    children: [
                      TextSpan(
                        text: message.message,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
