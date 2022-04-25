import 'package:client_app/application/infra/scroll_and_drag_scroll_behaviour.dart';
import 'package:client_app/domain/app_chat.dart';
import 'package:client_app/domain/auth/auth_provider.dart';
import 'package:client_app/pages/chatroom/widgets/chatroom_single_participant.widget.dart';
import 'package:flutter/material.dart';

class ChatroomParticipantsWidget extends StatelessWidget {
  const ChatroomParticipantsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: StreamBuilder<AppSyncData>(
          stream: AppChatRepository().onSync(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              AppChatRepository().requestSync(
                  AppAuthProvider.of(context).loggedUser!.nickname);
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = snapshot.data!;
            return SizedBox(
              child: ScrollAndDragScrollBehavior.config(
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        Text('Participants',
                            style: Theme.of(context).textTheme.headline4),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('Online: ${data.nicknames.length}',
                              style: const TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 48),
                    for (final participant in [...data.nicknames])
                      ChatroomSingleParticipantWidget(name: participant),
                  ]),
                ),
              ),
            );
          }),
    );
  }
}