import 'dart:io';

import 'domain/app_client.dart';
import 'domain/app_message.dart';
import 'domain/messages/connected_message.dart';
import 'domain/messages/disconnected_message.dart';
import 'domain/messages/text_message.dart';

const port = 8080;
final repository = AppClientRepository();

Future<void> main(List<String> arguments) async {
  print('Trying to start server at port $port....');

  final server = await ServerSocket.bind(
    InternetAddress.anyIPv4,
    port,
    shared: true,
  );

  server.listen((Socket socket) {
    socket.listen((bytes) {
      final message = AppMessage.fromBytes(bytes);

      if (message is ConnectedMessage) {
        onSocketConnected(socket, message);
      } else if (message is TextMessage) {
        onSocketTextMessage(socket, message);
      } else if (message is DisconnectedMessage) {
        onSocketDisconnected(socket, message);
      } else {
        print('Unknown message type: ${message.runtimeType}');
      }
    }, onDone: () {
      onSocketDone(socket);
    }, onError: (err, stack) {
      onSocketError(socket, err, stack);
    });
  });

  print('Server started @$port!');
}

void onSocketConnected(Socket socket, ConnectedMessage message) {
  final client = AppClient.create(socket, nickname: message.data.nickname);

  if (repository.existsByNickname(client.nickname)) {
    print('nickname ${client.nickname} already taken!');
    return;
  }

  repository.add(client);
  print('Client connected: ${client.describe}');
}

void onSocketTextMessage(Socket socket, TextMessage message) {
  AppClient? client = repository.findByNickname(message.data.from);
  if (client == null) {
    print('Client not found: ${message.data.from}');
    return;
  }

  AppClient? toClient = repository.findByNickname(message.data.to);
  if (toClient == null) {
    print('Client not found: ${message.data.to}');
    return;
  }

  toClient.send(TextMessage(
    TextData(
      from: client.nickname,
      to: toClient.nickname,
      content: message.data.content,
    ),
  ));
}

void onSocketDisconnected(Socket socket, DisconnectedMessage message) {
  final client = repository.findByNickname(message.data.nickname);

  if (client == null) {
    print('Client not found: ${message.data.nickname}');
    return;
  }

  repository.remove(client);
  print('Client disconnected: ${client.describe}');
}

void onSocketDone(Socket socket) {
  print('onDone!! ');
  repository.findClientsBySocket(socket).forEach((elm) {
    print('disconnected ${elm.nickname} (DONE)');
    // repository.remove(elm);
  });
}

void onSocketError(Socket socket, err, stack) {
  repository.findClientsBySocket(socket).forEach((elm) {
    print('disconnected ${elm.nickname} (ERROR)');
    // repository.remove(elm);
  });
}
