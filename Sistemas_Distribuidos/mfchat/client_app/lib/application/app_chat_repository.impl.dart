import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:client_app/domain/app_chat.dart';

class AppChatRepositoryImpl implements AppChatRepository {
  AppChatRepositoryImpl._();
  static final AppChatRepositoryImpl instance = AppChatRepositoryImpl._();

  static final _messagesStreamCtrl =
      StreamController<AppChatMessage>.broadcast();

  static final _syncDataStreamCtrl = StreamController<AppSyncData>.broadcast();
  static get _syncDataStream => _syncDataStreamCtrl.stream;

  Socket? socket;

  @override
  Future<void> connect(String username) async {
    socket = await Socket.connect('localhost', 8100);
    socket!.listen(
      _onSocketData,
      onDone: _onSocketDone,
      onError: _onSocketError,
    );
    await Future.delayed(const Duration(seconds: 1));
    await _sendMessage(socket!, MsgType.connect, {'nickname': username});
  }

  @override
  Future<void> text(AppChatMessage message) async {
    await _sendMessage(socket!, MsgType.text, message.toMap());
  }

  @override
  Future<void> disconnect(String username) async {
    await _sendMessage(socket!, MsgType.disconnect, {'nickname': username});
  }

  @override
  Future<void> requestSync(String username) async {
    await _sendMessage(socket!, MsgType.requestSync, {'nickname': username});
  }

  @override
  Stream<AppChatMessage> onMessage() {
    return _messagesStreamCtrl.stream;
  }

  @override
  Stream<AppSyncData> onSync() {
    return _syncDataStream;
  }

  final List<int> _buffer = [];

  void _onSocketData(Uint8List data) {
    _buffer.addAll(data);
    if (_buffer.length < 12) {
      return;
    }

    final jsonSizePart = int.parse(String.fromCharCodes(_buffer.sublist(0, 8)));
    if (_buffer.length < (jsonSizePart + 12)) {
      return;
    }

    final _messageBuffer = [..._buffer];
    _buffer.clear();
    final typePart =
        int.parse(String.fromCharCodes(_messageBuffer.sublist(9, 11)));
    final jsonMessage =
        utf8.decode(_messageBuffer.sublist(12, 12 + jsonSizePart));

    final type = EvtType.values[typePart];
    if (type == EvtType.textMessage) {
      final message = AppChatMessage.fromJson(jsonMessage);
      _messagesStreamCtrl.add(message);
    } else if (type == EvtType.sync) {
      final syncData = AppSyncData.fromJson(jsonMessage);
      _syncDataStreamCtrl.sink.add(syncData);
    }

    // _buffer.addAll(data);
    // while (_buffer.length >= 4) {
    //   final int length =
    //       _buffer[0] << 24 | _buffer[1] << 16 | _buffer[2] << 8 | _buffer[3];
    //   if (_buffer.length < length + 4) {
    //     break;
    //   }
    //   final Uint8List message =
    //       Uint8List.fromList(_buffer.sublist(4, length + 4));
    //   _buffer.removeRange(0, length + 4);
    //   final Map<String, dynamic> decoded = jsonDecode(utf8.decode(message));
    //   final AppChatMessage chatMessage =
    //       AppChatMessage.fromJson(jsonEncode(decoded));
    //   _streamController.add(chatMessage);
    // }
  }

  void _onSocketDone() {}
  void _onSocketError(err) {}
}

enum EvtType { sync, textMessage }
enum MsgType { connect, text, disconnect, requestSync }

Future<void> _sendMessage(
  Socket conn,
  MsgType type,
  Map<String, dynamic> data,
) async {
  final jsonData = json.encode(data);

  final jsonSizePart = jsonData.length.toString().padLeft(8, '0');
  final typePart = type.index.toString().padLeft(2, '0');

  final message = '$jsonSizePart.$typePart.$jsonData';
  conn.add(utf8.encode(message));
  conn.flush();
  await Future.delayed(const Duration(milliseconds: 1));
}

  // Uint8List toBytes() {
  //   final payload = data?.toJson() ?? '{}';
  //   final buffer = Uint8List(3 + payload.length);
  //   final dataBytes = utf8.encode(payload.trim());
  //   buffer.setRange(
  //       0, 3, type.index.toString().padLeft(3, '0').trim().codeUnits);
  //   buffer.setRange(3, 3 + dataBytes.length, dataBytes);
  //   return buffer;
  // }
