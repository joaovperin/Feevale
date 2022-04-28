import 'dart:io';

import 'domain/app_client.dart';
import 'domain/events/app_events.dart';
import 'domain/messages/connected_message.dart';
import 'domain/messages/disconnected_message.dart';
import 'domain/messages/request_sync_message.dart';
import 'domain/messages/text_message.dart';

final clientsRepository = AppClientRepository();

void _broadcastEvt(AppEvent event) {
  final _allClients = clientsRepository.listClients();
  final evtBytes = event.toBytes();
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

  final _allUsers =
      clientsRepository.listClients().map((e) => e.nickname).toList();
  _broadcastEvt(AppEvent.userConnected(client.nickname));
  _broadcastEvt(AppEvent.sync(_allUsers));
}

void onSocketTextMessage(Socket socket, TextMessage message) {
  final msg = TextMessage(
    TextData(
      from: message.data.from,
      to: message.data.to,
      content: message.data.content,
    ),
  );

// Broadcast message to all clients
  if (msg.data.to == 'all') {
    final msgBytes = msg.toBytes();
    clientsRepository.listClients().forEach((c) {
      c.socket.add(msgBytes);
    });
    return;
  }
  // Send message to sender and receiver clients
  AppClient? from = clientsRepository.findByNickname(message.data.from);
  if (from == null) {
    print('Client (from) not found: ${message.data.from}');
    return;
  }
  AppClient? to = clientsRepository.findByNickname(message.data.to);
  if (to == null) {
    print('Client (to) not found: ${message.data.to}');
    return;
  }
  to.socket.add(msg.toBytes());
  from.socket.add(msg.toBytes());
}

void onSocketDisconnected(Socket socket, DisconnectedMessage message) {
  final client = clientsRepository.findByNickname(message.data.nickname);

  if (client == null) {
    print('Client not found: ${message.data.nickname}');
    return;
  }

  clientsRepository.remove(client);
  print('Client disconnected: ${client.describe}');

  final _allUsers =
      clientsRepository.listClients().map((e) => e.nickname).toList();
  _broadcastEvt(AppEvent.userDisconnected(client.nickname));
  _broadcastEvt(AppEvent.sync(_allUsers));
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
