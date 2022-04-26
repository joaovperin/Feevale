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
