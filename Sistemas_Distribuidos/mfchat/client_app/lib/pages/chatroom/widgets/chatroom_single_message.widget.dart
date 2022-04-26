import 'package:client_app/domain/app_chat.dart';
import 'package:flutter/material.dart';

const currentUser = 'joaovperin';

class ChatroomSingleMessageWidget extends StatelessWidget {
  const ChatroomSingleMessageWidget(this.message, {Key? key}) : super(key: key);

  final AppChatMessage message;

  @override
  Widget build(BuildContext context) {
    // TODO: add container and change color if message related to user
    //// decoration: BoxDecoration(
    /////// color: message.to == 'all' ? null : Colors.blue.withAlpha(30),
    /////// color: message.from == 'currentUser' && message.to != 'all' ? null : Colors.amber.withAlpha(30), // ver percent
    //   color: message.from == 'currentUser' && message.to == 'all' ? null : Colors.blue.withAlpha(30),
    //   color: (message.from == 'currentUser' && message.to != 'all') || message.to == 'currentUser' ? null : Colors.amber.withAlpha(30), // ver percent
    // ),
    return Container(
      decoration: BoxDecoration(color: _getColor()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 10),
                    text: 'From ',
                    children: [
                      TextSpan(
                        text: message.from,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: ' to '),
                      TextSpan(
                        text: message.to,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(message.content),
        ],
      ),
    );
  }

  Color? _getColor() {
    if (message.from == currentUser) {
      if (message.to == 'all') {
        return Colors.blue.withAlpha(30);
      }
      return Colors.yellow.withAlpha(60);
    }
    if (message.to == currentUser) {
      return Colors.orange.withAlpha(60);
    }

    return null;
  }
}
