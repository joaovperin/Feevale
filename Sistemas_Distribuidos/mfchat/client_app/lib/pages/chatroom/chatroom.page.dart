import 'package:client_app/domain/auth/auth_provider.dart';
import 'package:client_app/domain/chat_message.dart';
import 'package:client_app/pages/chatroom/widgets/chatroom_messages.widget.dart';
import 'package:client_app/pages/chatroom/widgets/chatroom_participants.widget.dart';
import 'package:client_app/pages/chatroom/widgets/chatroom_typing_field.widget.dart';
import 'package:flutter/material.dart';

class ChatroomPage extends StatefulWidget {
  static const routeName = '/chatroom';
  const ChatroomPage({Key? key}) : super(key: key);

  final String chatroomName = 'Main room';

  @override
  State<ChatroomPage> createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage> {
  late ScrollController _scrollController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MfChat - ${widget.chatroomName} (new)'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              AppAuthProvider.of(context)
                  .logout()
                  .then((_) => Navigator.of(context).pop());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: ChatroomParticipantsWidget(),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: ChatroomMessagesWidget(
                            scrollController: _scrollController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 4),
                  child: Container(
                    width: 320,
                    height: 90,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: const Text(
                      'Compre já nas americanas!!!\nClique aqui e seja feliz',
                    ),
                  ),
                ),
                Expanded(
                  child: ChatroomTypingFieldWidget(
                    onSubmit: _sendMessage,
                    focusNode: _focusNode,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 112),
        child: FloatingActionButton(
          tooltip: 'Scroll down',
          child: const Icon(Icons.arrow_downward),
          onPressed: () {
            _scrollToBottom();
          },
        ),
      ),
    );
  }

  void _sendMessage(String message) {
    if (message.trim().isEmpty) {
      return;
    }
    final _chatMessage = ChatMessage(message.trim());
    ChatMessageRepository().send(_chatMessage);
    _scrollToBottom();
    _focusNode.requestFocus();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 99,
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
    );
  }
}