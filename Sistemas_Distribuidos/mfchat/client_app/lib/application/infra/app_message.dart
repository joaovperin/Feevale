import 'dart:convert';
import 'dart:typed_data';

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
    final dataBytes = utf8.encode(payload.trim());
    buffer.setRange(
        0, 3, type.index.toString().padLeft(3, '0').trim().codeUnits);
    buffer.setRange(3, 3 + dataBytes.length, dataBytes);
    return buffer;
  }
}
