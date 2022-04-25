import 'package:client_app/domain/auth/auth_provider.dart';
import 'package:flutter/material.dart';

class ChatroomSingleParticipantWidget extends StatelessWidget {
  const ChatroomSingleParticipantWidget({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    final _currentLoggedUser = AppAuthProvider.of(context).loggedUser!.nickname;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (name == _currentLoggedUser)
                Text(
                  '$name (You)',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              if (name != _currentLoggedUser) Text(name),
              const Spacer(),
              if (name == _currentLoggedUser) const SizedBox(height: 48),
              if (name != _currentLoggedUser)
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline_rounded),
                  tooltip: 'Send message',
                  onPressed: () {
                    // TODO: Open conversation
                  },
                ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
