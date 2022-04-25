import 'package:client_app/application/infra/scroll_and_drag_scroll_behaviour.dart';
import 'package:client_app/domain/app_chat.dart';
import 'package:client_app/pages/chatroom/widgets/chatroom_single_message.widget.dart';
import 'package:flutter/material.dart';

class ChatroomMessagesWidget extends StatefulWidget {
  const ChatroomMessagesWidget(
      {Key? key, required ScrollController scrollController})
      : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;

  @override
  State<ChatroomMessagesWidget> createState() => _ChatroomMessagesWidgetState();
}

class _ChatroomMessagesWidgetState extends State<ChatroomMessagesWidget> {
  final List<AppChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();

    AppChatRepository().onMessage().listen((message) {
      setState(() {
        _messages.add(message);
        // TODO: Testar
        widget._scrollController.animateTo(
          widget._scrollController.position.maxScrollExtent + 99,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: SizedBox(
        child: ScrollAndDragScrollBehavior.config(
          child: ListView.separated(
            controller: widget._scrollController,
            itemCount: _messages.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return ChatroomSingleMessageWidget(_messages[index]);
            },
          ),
        ),
      ),
    );
  }
}
