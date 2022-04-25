import 'dart:convert';

enum AppEventType {
  sync,
  textMessage,
  error,
}

class AppEvent {
  final AppEventType type;
  final dynamic data;

  const AppEvent._(this.type, {required this.data});

  factory AppEvent.sync(List<String> connectedNicknames) =>
      AppEvent._(AppEventType.sync, data: connectedNicknames);

  factory AppEvent.error(String cause) =>
      AppEvent._(AppEventType.error, data: cause);

  List<int> toBytes() {
    final jsonData = json.encode(data);

    final jsonSizePart = jsonData.length.toString().padLeft(8, '0');
    final typePart = type.index.toString().padLeft(2, '0');

    final message = '$jsonSizePart.$typePart.$jsonData';
    return utf8.encode(message);
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      'data': data,
    };
  }
}
