import 'dart:io';

import 'domain/app_client.dart';
import 'domain/events/app_events.dart';
import 'domain/messages/connected_message.dart';
import 'domain/messages/disconnected_message.dart';
import 'domain/messages/request_sync_message.dart';
import 'domain/messages/text_message.dart';

final clientsRepository = AppClientRepository();

void broadcastEvt(AppEvent event) {
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
  broadcastEvt(AppEvent.sync(_allUsers));
  Future.delayed(const Duration(milliseconds: 50), () {
    broadcastEvt(AppEvent.userConnected(client.nickname));
  });
}

final _forbiddenWordsList = ['palavr[ãa]o', 'fei[oa]s?', 'bobalh[aã]o'];

void onSocketTextMessage(Socket socket, TextMessage message) {
  // Forbidden word filter
  final _lowerCasedText = message.data.content.toLowerCase();
  for (final forbiddenWord in _forbiddenWordsList) {
    if (RegExp(forbiddenWord).hasMatch(_lowerCasedText)) {
      socket.add(
        AppEvent.serverMessageError(
          'Your message was not sent because it contains a forbidden word.',
        ).toBytes(),
      );
      return;
    }
  }

  final msg = TextMessage(
    TextData(
      from: message.data.from,
      to: message.data.to,
      content: message.data.content,
      datetime: message.data.datetime,
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
    socket.add(
      AppEvent.serverMessageError(
        'Fail to send message, because the sender "${message.data.to}" is not connected!',
      ).toBytes(),
    );

    return;
  }
  AppClient? to = clientsRepository.findByNickname(message.data.to);
  if (to == null) {
    print('Client (to) not found: ${message.data.to}');
    socket.add(AppEvent.serverMessageError(
      'Fail to send message, because the target "${message.data.to}" is not connected!',
    ).toBytes());
    return;
  }
  to.socket.add(msg.toBytes());
  from.socket.add(msg.toBytes());
}

void onSocketDisconnected(Socket socket, DisconnectedMessage message) {
  final client = clientsRepository.findByNickname(message.data.nickname);

  if (client == null) {
    print('Client not found: ${message.data.nickname}');
    socket.add(AppEvent.serverMessageError(
      'Fail to disconnect ${message.data.nickname} from the server! Nickname not found!',
    ).toBytes());
    return;
  }

  clientsRepository.remove(client);
  print('Client disconnected: ${client.describe}');

  final _allUsers =
      clientsRepository.listClients().map((e) => e.nickname).toList();
  broadcastEvt(AppEvent.sync(_allUsers));
  Future.delayed(const Duration(milliseconds: 50), () {
    broadcastEvt(AppEvent.userDisconnected(client.nickname));
  });
}

void onSocketRequestSync(Socket socket, RequestSyncMessage message) {
  final client = clientsRepository.findByNickname(message.data.nickname);

  if (client == null) {
    print('Client not found: ${message.data.nickname}');
    socket.add(AppEvent.serverMessageError(
      'Fail to sync ${message.data.nickname}! Nickname not found!',
    ).toBytes());
    return;
  }

  final _allClients = clientsRepository.listClients();
  final _syncEvent = AppEvent.sync(
    _allClients.map((e) => e.nickname).toList(),
  );
  client.socket.add(_syncEvent.toBytes());
}

void disconnectRelatedClients(Socket socket, String reason) {
  clientsRepository.findClientsBySocket(socket).forEach((elm) {
    print('disconnected ${elm.nickname} ($reason)');
    clientsRepository.remove(elm);
  });
}
