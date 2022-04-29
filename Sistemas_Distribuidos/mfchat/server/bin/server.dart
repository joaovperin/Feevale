import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'chat_service.dart';
import 'domain/app_message.dart';
import 'domain/messages/connected_message.dart';
import 'domain/messages/disconnected_message.dart';
import 'domain/messages/request_sync_message.dart';
import 'domain/messages/text_message.dart';
import 'reminder_service.dart';

const defaultPort = 8100;

Future<void> main(List<String> arguments) async {
  int port = defaultPort;
  if (arguments.isNotEmpty) {
    port = int.parse(arguments.first);
  }
  print('Trying to start server at port $port....');

  final server = await ServerSocket.bind(
    InternetAddress.anyIPv6,
    port,
    shared: true,
  );
  // Reminders
  Future.delayed(const Duration(seconds: 15)).then((_) {
    Timer.periodic(const Duration(seconds: 60), (timer) {
      broadcastAnyReminder();
    });
  });

  server.listen((Socket socket) {
    final Map<Socket, List<int>> _buffer = {};

    socket.listen((bytes) {
      if (bytes.isEmpty) {
        return;
      }

      try {
        _buffer[socket] ??= [];
        final buff = _buffer[socket]!;
        buff.addAll(bytes);

        if (buff.length < 12) {
          return;
        }
        final jsonSizePart =
            int.parse(String.fromCharCodes(buff.sublist(0, 8)));
        if (buff.length < (jsonSizePart + 12)) {
          return;
        }

        final _messageBuffer = [...buff];
        buff.clear();
        final typePart =
            int.parse(String.fromCharCodes(_messageBuffer.sublist(9, 11)));
        final strrr = _messageBuffer.sublist(12, 12 + jsonSizePart);
        final jsonMessage = utf8.decode(strrr);
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
            print('invalid message type $type, socket invalid!');
            socket.destroy();
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
          return;
        }
      } catch (err, stack) {
        print('Err: $err');
        print('Stack: $stack');
        disconnectRelatedClients(socket, 'catch: $err');
        socket.destroy();
      }
    }, onDone: () {
      disconnectRelatedClients(socket, 'SOCKET_DONE');
    }, onError: (err, stack) {
      disconnectRelatedClients(socket, 'SOCKET_ONERROR');
      socket.destroy();
    });
  });

  print('Server started @$port!');
}
