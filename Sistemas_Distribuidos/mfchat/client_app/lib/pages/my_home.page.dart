import 'dart:async';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  final String title = 'Simple demo chat';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const _initialData = <String>[
  'Hello, fella!',
  'How are you?',
  'I\'m fine, thanks.',
  'What\'s your name?',
  'My name is Dart.',
  'How old are you?',
  'I\'m 29 years old.',
  'Where are you from?',
  'I\'m from Russia.',
  'What\'s your favorite color?',
  'I\'m blue.',
  'What\'s your favorite animal?',
  'I\'m a cat.',
  'What\'s your favorite food?',
  'I\'m pizza.',
  'What\'s your favorite sport?',
  'I\'m basketball.',
  'What\'s your favorite TV show?',
  'I\'m The Simpsons.',
  'What\'s your favorite movie?',
  'I\'m The Matrix.',
  'What\'s your favorite book?',
  'I\'m The Lord of the Rings.',
  'What\'s your favorite song?',
  'I\'m The Beatles.',
  'What\'s your favorite game?',
  'I\'m Minecraft.',
  'What\'s your favorite animal?',
  'I\'m a dog.',
  'What\'s your favorite food?',
  'I\'m sushi.',
  'What\'s your favorite sport?',
  'I\'m football.',
];

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _textController;
  late StreamController<String> _streamController;
  late ScrollController _scrollController;
  late FocusNode _focusNode;

  final _messages = [..._initialData];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _scrollController = ScrollController();
    _focusNode = FocusNode();
    _streamController = StreamController<String>.broadcast();

    _streamController.stream.listen((message) {
      _textController.clear();
      if (message.trim().isEmpty) {
        return;
      }
      setState(() {
        _messages.add(message.trim());
      });
      _focusNode.requestFocus();
      Future.delayed(const Duration(milliseconds: 300))
          .then((_) => _scrollDown());
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _streamController.close();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                    return Text(_messages[index]);
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
                    _streamController.add(_textController.text);
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Enter text',
                    suffix: IconButton(
                      icon: const Icon(Icons.send),
                      tooltip: 'Send',
                      onPressed: () {
                        _streamController.add(_textController.text);
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
