import 'dart:convert';
import 'dart:io';

import 'chat_service.dart';
import 'domain/app_message.dart';
import 'domain/messages/connected_message.dart';
import 'domain/messages/disconnected_message.dart';
import 'domain/messages/request_sync_message.dart';
import 'domain/messages/text_message.dart';

const port = 8100;

Future<void> main(List<String> arguments) async {
  print('Trying to start server at port $port....');

  final server = await ServerSocket.bind(
    InternetAddress.anyIPv4,
    port,
    shared: true,
  );

  server.listen((Socket socket) {
    final Map<Socket, List<int>> _buffer = {};
    socket.listen((bytes) {
      _buffer[socket] ??= [];
      final buff = _buffer[socket]!;
      buff.addAll(bytes);

      if (buff.length < 12) {
        return;
      }
      final jsonSizePart = int.parse(String.fromCharCodes(buff.sublist(0, 8)));
      if (buff.length < (jsonSizePart + 12)) {
        return;
      }

      final _messageBuffer = [...buff];
      buff.clear();
      final typePart =
          int.parse(String.fromCharCodes(_messageBuffer.sublist(9, 11)));
      final jsonMessage =
          utf8.decode(_messageBuffer.sublist(12, 12 + jsonSizePart));
      final type = AppMessageType.values[typePart];

      AppMessage message;
      switch (type) {
        case AppMessageType.connected:
          message = ConnectedMessage.parse(jsonMessage);
          break;
        case AppMessageType.text:
          message = TextMessage.parse(jsonMessage);
          break;
        case AppMessageType.disconnected:
          message = DisconnectedMessage.parse(jsonMessage);
          break;
        case AppMessageType.requestSync:
          message = RequestSyncMessage.parse(jsonMessage);
          break;
        default:
          print('invalid message type $type, ignoring!');
          return;
      }

      if (message is ConnectedMessage) {
        onSocketConnected(socket, message);
      } else if (message is TextMessage) {
        onSocketTextMessage(socket, message);
      } else if (message is DisconnectedMessage) {
        onSocketDisconnected(socket, message);
      } else if (message is RequestSyncMessage) {
        onSocketRequestSync(socket, message);
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
