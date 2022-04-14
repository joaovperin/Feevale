import 'dart:convert';
import 'dart:typed_data';

import 'messages/connected_message.dart';
import 'messages/disconnected_message.dart';
import 'messages/text_message.dart';

enum AppMessageType {
  connected, // 001{} Connected
  text, // 002{"target":"a8b76d-s3g5n","text":"hello"} Text Message
  disconnected, // 003{} Disconnected
}

extension AppMessageStrategy on AppMessageType {
  bool get hasData => const [
        AppMessageType.text,
        AppMessageType.connected,
        AppMessageType.disconnected,
      ].contains(this);
}

abstract class AppMessageData {
  const AppMessageData();
  String toJson();
}

class AppMessage<T extends AppMessageData> {
  final AppMessageType type;
  final T? data;

  const AppMessage(this.type, [this.data]);

  Uint8List toBytes() {
    final payload = data?.toJson() ?? '{}';
    final buffer = Uint8List(3 + payload.length);
    // buffer[0] = 0;
    // buffer[1] = 0;
    // buffer[2] = type.index;
    final dataBytes = utf8.encode(payload.trim());
    buffer.setRange(
        0, 3, type.index.toString().padLeft(3, '0').trim().codeUnits);
    buffer.setRange(3, 3 + dataBytes.length, dataBytes);
    return buffer;
  }

  static AppMessage fromBytes(Uint8List data) {
    final typeIdx = int.parse(String.fromCharCodes([...data.getRange(0, 3)]));
    final type = AppMessageType.values[typeIdx];

    String? dataString;
    if (type.hasData) {
      dataString = utf8.decode(data.sublist(3)).trim();
    }

    switch (type) {
      case AppMessageType.connected:
        return ConnectedMessage.parse(dataString!);
      case AppMessageType.text:
        return TextMessage.parse(dataString!);
      case AppMessageType.disconnected:
        return DisconnectedMessage.parse(dataString!);
      default:
        throw Exception('Unknown message type: $type');
    }
  }
}
