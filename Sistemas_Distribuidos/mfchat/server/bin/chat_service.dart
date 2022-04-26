import 'dart:io';

import 'domain/app_client.dart';
import 'domain/events/app_events.dart';
import 'domain/messages/connected_message.dart';
import 'domain/messages/disconnected_message.dart';
import 'domain/messages/request_sync_message.dart';
import 'domain/messages/text_message.dart';

final clientsRepository = AppClientRepository();

void _broadcastSync() {
  final _allClients = clientsRepository.listClients();
  final _syncEvent = AppEvent.sync(
    _allClients.map((e) => e.nickname).toList(),
  );
  final evtBytes = _syncEvent.toBytes();
  for (final c in _allClients) {
    c.socket.add(evtBytes);
  }
}

void onSocketConnected(Socket socket, ConnectedMessage message) {
  final client = AppClient.create(socket, nickname: message.data.nickname);

  if (clientsRepository.existsByNickname(client.nickname)) {
    print('nickname ${client.nickname} already taken!');
    socket.add(
      AppEvent.error(
        'Nickname ${client.nickname} is already taken! Please choose another one.',
      ).toBytes(),
    );
    return;
  }

  clientsRepository.add(client);
  print('Client connected: ${client.describe}');
  _broadcastSync();
}

void onSocketTextMessage(Socket socket, TextMessage message) {
  final msg = TextMessage(
    TextData(
      from: message.data.from,
      to: message.data.to,
      content: message.data.content,
    ),
  );

  AppClient? from = clientsRepository.findByNickname(message.data.from);
  if (from == null) {
    print('Client not found: ${message.data.from}');
    return;
  }

  if (msg.data.to == 'all') {
    final msgBytes = msg.toBytes();
    clientsRepository.listClients().forEach((c) {
      c.socket.add(msgBytes);
    });
  } else {
    AppClient? to = clientsRepository.findByNickname(message.data.to);
    if (to == null) {
      print('Client not found: ${message.data.to}');
      return;
    }
    to.socket.add(msg.toBytes());
  }
}

void onSocketDisconnected(Socket socket, DisconnectedMessage message) {
  final client = clientsRepository.findByNickname(message.data.nickname);

  if (client == null) {
    print('Client not found: ${message.data.nickname}');
    return;
  }

  clientsRepository.remove(client);
  print('Client disconnected: ${client.describe}');
  _broadcastSync();
}

void onSocketRequestSync(Socket socket, RequestSyncMessage message) {
  final client = clientsRepository.findByNickname(message.data.nickname);

  if (client == null) {
    print('Client not found: ${message.data.nickname}');
    return;
  }

  final _allClients = clientsRepository.listClients();
  final _syncEvent = AppEvent.sync(
    _allClients.map((e) => e.nickname).toList(),
  );
  client.socket.add(_syncEvent.toBytes());
}

void onSocketDone(Socket socket) {
  print('onDone!! ');
  clientsRepository.findClientsBySocket(socket).forEach((elm) {
    print('disconnected ${elm.nickname} (DONE)');
    // repository.remove(elm);
  });
}

void onSocketError(Socket socket, err, stack) {
  clientsRepository.findClientsBySocket(socket).forEach((elm) {
    print('disconnected ${elm.nickname} (ERROR)');
    // repository.remove(elm);
  });
}
