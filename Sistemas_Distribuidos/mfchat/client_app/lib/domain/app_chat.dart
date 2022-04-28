import 'dart:convert';

import 'package:client_app/application/app_chat_repository.impl.dart';

abstract class AppChatRepository {
  factory AppChatRepository() => AppChatRepositoryImpl.instance;

  Future<void> connect(String address, int port, String username);
  Future<void> text(AppChatMessage message);
  Future<void> disconnect(String username);
  Future<void> requestSync(String username);

  Stream<AppChatMessage> onMessage();
  Stream<AppSyncData> onSync();
  Stream<AppServerMessageData> onServerMessage();
  Stream<AppErrorData> onError();
}

abstract class AppItemList {}

class AppServerMessage implements AppItemList {
  final String icon;
  final String message;

  const AppServerMessage(this.icon, this.message);
}

class AppChatMessage implements AppItemList {
  final String from;
  final String to;
  final String content;
  final DateTime datetime;

  const AppChatMessage(
    this.content, {
    required this.from,
    required this.to,
    required this.datetime,
  });

  factory AppChatMessage.fromJson(String json) {
    final data = jsonDecode(json);
    return AppChatMessage(
      data['content'] as String,
      from: data['from'] as String,
      to: data['to'] as String,
      datetime: DateTime.parse(data['datetime'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'from': from,
      'to': to,
      'content': content,
      'datetime': datetime.toIso8601String(),
    };
  }
}

class AppSyncData {
  final List<String> nicknames;

  const AppSyncData(this.nicknames);

  factory AppSyncData.fromJson(String json) {
    final data = jsonDecode(json);
    return AppSyncData(
      List<String>.from(data.map((e) => e as String)),
    );
  }
}

class AppServerMessageData {
  final String icon;
  final String message;

  const AppServerMessageData(this.icon, this.message);

  factory AppServerMessageData.fromJson(String json) {
    final data = jsonDecode(json);
    return AppServerMessageData(
      data['icon'] as String,
      data['message'] as String,
    );
  }
}

class AppUserDisconnectData {
  final String nickname;
  final List<String> allUsers;

  const AppUserDisconnectData(this.nickname, this.allUsers);

  factory AppUserDisconnectData.fromJson(String json) {
    final data = jsonDecode(json);
    return AppUserDisconnectData(
      data['user'] as String,
      List<String>.from(data['list'].map((e) => e as String)),
    );
  }
}

class AppErrorData {
  final String cause;

  const AppErrorData(this.cause);

  factory AppErrorData.fromJson(String json) {
    final data = jsonDecode(json);
    return AppErrorData(data);
  }
}
