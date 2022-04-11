import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:uuid/uuid.dart';

const port = 8080;
final _allClients = <ConnectedClient>[];

Future<void> main(List<String> arguments) async {
  print('Trying to start server at port $port....');

  final server = await ServerSocket.bind(
    InternetAddress.anyIPv4,
    8080,
    shared: true,
  );

  server.listen((Socket socket) {
    socket.first.then((firstMessage) {
      final _connectedData = ConnectedMessage.fromBytes(firstMessage);

      final client = ConnectedClient(socket, nickname: _connectedData.nickname);

      if (_allClients.any((e) => e.nickname == _connectedData.nickname)) {
        client.sendMessage('Nickname already taken!');
        return;
      }

      print('Client connected: ${client.describe}');
      _allClients.add(client);

      socket.listen((message) {
        final msg = ChatMessage.fromBytes(message);
        client.onMessage(msg);
      }, onDone: () {
        print('Client disconnected: ${client.describe}');
        client.onDisconnect();
        _allClients.remove(client);
      });
    });
  });

  print('Server started!');
}

class ConnectedClient {
  final String id;
  final Socket socket;
  String nickname;

  ConnectedClient(
    this.socket, {
    required this.nickname,
  }) : id = Uuid().v4();

  String get addr => '${socket.remoteAddress.address}:${socket.remotePort}';
  String get describe => addr;

  void onMessage(ChatMessage message) {
    print('Received data: ${message.text}');
    if (message.text == '111') {
      sendMessage('222');
    } else if (message.text == '222') {
      sendMessage('333');
    } else if (message.text == '333') {
      sendMessage('444');
    } else if (message.text == '444') {
      sendMessage('555');
    } else if (message.text == '555') {
      sendMessage('666');
    } else if (message.text == '666') {
      sendMessage('777');
    } else if (message.text == '777') {
      sendMessage('888');
    } else if (message.text == '888') {
      sendMessage('999');
    } else if (message.text == '999') {
      sendMessage('000');
    } else if (message.text == '000') {
      sendMessage('111');
    } else {
      sendMessage('FOR YOU TOO: ${message.text}');
    }
  }

  void sendMessage(String text) {
    final msg = ChatMessage(text);
    socket.write(msg.toBytes());
  }

  void onDisconnect() {
    socket.close();
    socket.destroy();
  }
}

class ConnectedMessage {
  final String nickname;

  ConnectedMessage(this.nickname);

  factory ConnectedMessage.fromBytes(Uint8List bytes) {
    final json = jsonDecode(String.fromCharCodes(bytes));
    return ConnectedMessage(json['nickname'] as String);
  }
}

class ChatMessage {
  final String text;

  const ChatMessage(this.text);

  factory ChatMessage.fromBytes(Uint8List bytes) {
    final json = jsonDecode(String.fromCharCodes(bytes));
    return ChatMessage(json['text'] as String);
  }

  List<int> toBytes() {
    final json = {'text': text};
    return utf8.encode(jsonEncode(json));
  }
}
