import 'dart:async';
import 'dart:math';

import 'package:client_app/domain/chat_client.dart';
import 'package:client_app/domain/chat_message.dart';

const _idx = 5;
const _timeMin = 500;
const _timeSum = 2000;

class ChatClientRepositoryImpl implements ChatClientRepository {
  const ChatClientRepositoryImpl._();
  static const ChatClientRepositoryImpl instance = ChatClientRepositoryImpl._();

  static final _streamController = StreamController<ChatMessage>.broadcast();

  @override
  Future<void> send(ChatMessage message) async {
    _streamController.add(message);
  }

  @override
  Future<List<ChatClient>> firstLoad() async {
    _prepareStream();
    return [];
    // return _mockData.sublist(0, _idx).toList();
  }

  @override
  Stream<ChatMessage> onMessage() {
    return _streamController.stream;
  }

  Future<void> _prepareStream() async {
    await Future.delayed(const Duration(milliseconds: _timeMin));
    for (final msg in _mockData.sublist(_idx)) {
      final time = _timeMin + Random().nextInt(_timeSum);
      await Future.delayed(Duration(milliseconds: time));
      _streamController.add(msg);
    }
  }

  @override
  Stream<ChatClient> onClientConnected() {
    // TODO: implement onClientConnected
    throw UnimplementedError();
  }
}

const _mockData = <ChatMessage>[
  ChatMessage('Hello, fella!'),
  ChatMessage('How are you?'),
  ChatMessage('I\'m fine, thanks.'),
  ChatMessage('What\'s your name?'),
  ChatMessage('My name is Dart.'),
  ChatMessage('How old are you?'),
  ChatMessage('I\'m 29 years old.'),
  ChatMessage('Where are you from?'),
  ChatMessage('I\'m from Russia.'),
  ChatMessage('What\'s your favorite color?'),
  ChatMessage('I\'m blue.'),
  ChatMessage('What\'s your favorite animal?'),
  ChatMessage('I\'m a cat.'),
  ChatMessage('What\'s your favorite food?'),
  ChatMessage('I\'m pizza.'),
  ChatMessage('What\'s your favorite sport?'),
  ChatMessage('I\'m basketball.'),
  ChatMessage('What\'s your favorite TV show?'),
  ChatMessage('I\'m The Simpsons.'),
  ChatMessage('What\'s your favorite movie?'),
  ChatMessage('I\'m The Matrix.'),
  ChatMessage('What\'s your favorite book?'),
  ChatMessage('I\'m The Lord of the Rings.'),
  ChatMessage('What\'s your favorite song?'),
  ChatMessage('I\'m The Beatles.'),
  ChatMessage('What\'s your favorite game?'),
  ChatMessage('I\'m Minecraft.'),
  ChatMessage('What\'s your favorite animal?'),
  ChatMessage('I\'m a dog.'),
  ChatMessage('What\'s your favorite food?'),
  ChatMessage('I\'m sushi.'),
  ChatMessage('What\'s your favorite sport?'),
  ChatMessage('I\'m football.'),
];
