import 'dart:async';

import 'package:client_app/domain/chat_message.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  final String chatroomName = 'Simple demo chat';

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  late TextEditingController _textController;
  late ScrollController _scrollController;
  late FocusNode _focusNode;

  final List<ChatMessage> _messages = <ChatMessage>[];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _scrollController = ScrollController();
    _focusNode = FocusNode();

    ChatMessageRepository().firstLoad().then((messages) {
      setState(() {
        _messages.addAll(messages);
      });
    });

    ChatMessageRepository().onMessage().listen((msg) {
      setState(() {
        _messages.add(msg);
        _focusNode.requestFocus();
        Future.delayed(const Duration(milliseconds: 240))
            .then((_) => _scrollDown());
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 99,
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _sendMessage(String message) {
    if (message.trim().isEmpty) {
      return;
    }
    final _chatMessage = ChatMessage(message.trim());
    ChatMessageRepository().send(_chatMessage);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatroomName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: _messages.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return Text(_messages[index].text);
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Form(
                child: TextFormField(
                  controller: _textController,
                  focusNode: _focusNode,
                  onFieldSubmitted: (value) {
                    _sendMessage(_textController.text);
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Enter text',
                    suffix: IconButton(
                      icon: const Icon(Icons.send),
                      tooltip: 'Send',
                      onPressed: () {
                        _sendMessage(_textController.text);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
