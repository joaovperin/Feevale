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
  Stream<AppErrorData> onError();
}

class AppChatMessage {
  final String from;
  final String to;
  final String content;

  const AppChatMessage(
    this.content, {
    required this.from,
    required this.to,
  });

  factory AppChatMessage.fromJson(String json) {
    final data = jsonDecode(json);
    return AppChatMessage(
      data['content'] as String,
      from: data['from'] as String,
      to: data['to'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'from': from,
      'to': to,
      'content': content,
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

class AppErrorData {
  final String cause;

  const AppErrorData(this.cause);

  factory AppErrorData.fromJson(String json) {
    final data = jsonDecode(json);
    return AppErrorData(data);
  }
}
