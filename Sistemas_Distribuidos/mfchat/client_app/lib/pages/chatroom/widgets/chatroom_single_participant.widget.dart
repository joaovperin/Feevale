import 'package:client_app/domain/auth/app_auth_provider.dart';
import 'package:flutter/material.dart';

typedef OnTapParticipantFn = void Function(String nickname);

class ChatroomSingleParticipantWidget extends StatelessWidget {
  const ChatroomSingleParticipantWidget({
    Key? key,
    required this.name,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final bool selected;
  final OnTapParticipantFn onTap;

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
                  icon: Icon(
                    selected
                        ? Icons.chat_bubble
                        : Icons.chat_bubble_outline_rounded,
                    color: selected ? Colors.blue : null,
                  ),
                  tooltip: 'Send message to ${selected ? "all" : name}',
                  onPressed: () {
                    onTap.call(name);
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
