import 'dart:async';

import 'package:client_app/application/infra/scroll_and_drag_scroll_behaviour.dart';
import 'package:client_app/domain/chat_message.dart';
import 'package:flutter/material.dart';

class ChatRoomWithAdsPage extends StatefulWidget {
  static const routeName = '/chatroom';
  const ChatRoomWithAdsPage({Key? key}) : super(key: key);

  final String chatroomName = 'Main room';

  @override
  State<ChatRoomWithAdsPage> createState() => _ChatRoomWithAdsPageState();
}

class _ChatRoomWithAdsPageState extends State<ChatRoomWithAdsPage> {
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
            .then((_) => _scrollToBottom());
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

  void _scrollToBottom() {
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
        title: Text('MfChat - ${widget.chatroomName}'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => Navigator.of(context).pop(),
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
                    child: _ChatRoomParticipants(),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: ScrollAndDragScrollBehavior.config(
                              child: ListView.separated(
                                controller: _scrollController,
                                itemCount: _messages.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemBuilder: (context, index) {
                                  return Text(_messages[index].text);
                                },
                              ),
                            ),
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
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
}

class _ChatRoomParticipants extends StatelessWidget {
  const _ChatRoomParticipants({
    Key? key,
  }) : super(key: key);

  static const _participants = [
    'Alice',
    'Bob',
    'Charlie',
    'Dave',
    'Eve',
    'Frank',
    'Grace',
    'Heidi',
    'Iris',
    'Jack',
    'Kathy',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
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
                  child: Text('Online: ${_participants.length}',
                      style: const TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 48),
            for (final participant in _participants)
              _ParticipantWidget(name: participant),
          ]),
        ),
      ),
    );
  }
}

class _ParticipantWidget extends StatelessWidget {
  const _ParticipantWidget({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(name),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline_rounded),
                tooltip: 'Send message',
                onPressed: () {},
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
