import 'dart:convert';

enum AppEventType {
  sync,
  textMessage,
  error,
  serverMessage,
}

class AppServerMessage {
  final String icon;
  final String message;
  const AppServerMessage._(this.icon, this.message);

  factory AppServerMessage.error(String message) =>
      AppServerMessage._('⚠️ ', message);

  factory AppServerMessage.notification(String message) =>
      AppServerMessage._('🔔 ', message);

  factory AppServerMessage.pinned(String message) =>
      AppServerMessage._('📌 ', message);

  Map<String, String> toJson() {
    return {
      'icon': icon,
      'message': message,
    };
  }
}

class AppEvent {
  final AppEventType type;
  final dynamic data;

  const AppEvent._(this.type, {required this.data});

  factory AppEvent.sync(List<String> connectedNicknames) =>
      AppEvent._(AppEventType.sync, data: connectedNicknames);

  factory AppEvent.userConnected(String user) =>
      AppEvent._(AppEventType.serverMessage,
          data: AppServerMessage.notification('User $user is now online'));

  factory AppEvent.userDisconnected(String user) =>
      AppEvent._(AppEventType.serverMessage,
          data: AppServerMessage.notification('User $user is now offline'));

  factory AppEvent.error(String cause) =>
      AppEvent._(AppEventType.error, data: cause);

  List<int> toBytes() {
    final jsonData = json.encode(data);
    final jsonDataBytes = utf8.encode(jsonData);

    final jsonSizePart = jsonDataBytes.length.toString().padLeft(8, '0');
    final typePart = type.index.toString().padLeft(2, '0');

    return utf8.encode('$jsonSizePart.$typePart.') + jsonDataBytes;
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      'data': data,
    };
  }
}
