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

  static final _errorStreamCtrl = StreamController<AppErrorData>.broadcast();

  Socket? socket;
  final List<int> _dataBuffer = [];
  AppErrorData? _errorBuffer;

  @override
  Future<void> connect(String username) async {
    socket = await Socket.connect('localhost', 8100);
    socket!.listen(
      _onSocketData,
      onDone: _onSocketDone,
      onError: _onSocketError,
    );
    await _sendMessage(socket!, MsgType.connect, {'nickname': username});
    _errorBuffer = null;
    await Future.delayed(const Duration(seconds: 1));
    if (_errorBuffer != null) {
      throw _errorBuffer!.cause;
    }
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
    return _syncDataStreamCtrl.stream;
  }

  @override
  Stream<AppErrorData> onError() {
    return _errorStreamCtrl.stream;
  }

  void _onSocketData(Uint8List data) {
    _dataBuffer.addAll(data);
    if (_dataBuffer.length < 12) {
      return;
    }

    final jsonSizePart =
        int.parse(String.fromCharCodes(_dataBuffer.sublist(0, 8)));
    if (_dataBuffer.length < (jsonSizePart + 12)) {
      return;
    }

    final _messageBuffer = [..._dataBuffer];
    _dataBuffer.clear();
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
    } else if (type == EvtType.error) {
      _errorBuffer = AppErrorData.fromJson(jsonMessage);
      _errorStreamCtrl.sink.add(_errorBuffer!);
    }
  }

  void _onSocketDone() {}
  void _onSocketError(err) {}
}

enum EvtType { sync, textMessage, error }
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
