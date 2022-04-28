import 'package:client_app/domain/app_chat.dart';
import 'package:client_app/domain/auth/app_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatroomSingleMessageWidget extends StatelessWidget {
  const ChatroomSingleMessageWidget(this.message, {Key? key}) : super(key: key);

  final AppChatMessage message;
  static final timeFormat = DateFormat("HH:mm:ss");
  static final dateTimeFormat = DateFormat("MM-dd/MM/yyyy HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    final currentUser = AppAuthProvider.of(context).loggedUser!.nickname;
    return Container(
      decoration: BoxDecoration(color: _getColor(currentUser)),
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
                      TextSpan(text: ' (${_fmtDateTime(message.datetime)}) '),
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

  String _fmtDateTime(DateTime datetime) {
    if (datetime.day == DateTime.now().day) {
      return timeFormat.format(datetime);
    }
    return dateTimeFormat.format(datetime);
  }

  Color? _getColor(String currentUser) {
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
