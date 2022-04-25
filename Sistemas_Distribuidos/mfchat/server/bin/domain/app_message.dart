import 'dart:convert';
import 'dart:typed_data';

import 'messages/connected_message.dart';
import 'messages/disconnected_message.dart';
import 'messages/request_sync_message.dart';
import 'messages/text_message.dart';

enum AppMessageType {
  connected,
  text,
  disconnected,
  requestSync,
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

/// A Socket messsage.
///
/// Messages are composed by the payload length (8 bytes), the type (2 bytes) and the utf-8 encoded json message
///
/// Example:
/// 00000028.01.{"nickname":"a8b76d-s3g5n"} // 28 bytes connected message
/// 00000028.01.{"nickname":"b9m73d-m5g6f"} // 28 bytes connected message
/// 00000064.02.{"from":"a8b76d-s3g5n", "to":"b9m73d-m5g6f", "content":"hello"} // 64 bytes text message
/// 00000028.03.{"nickname":"b9m73d-m5g6f"} // 28 bytes disconnected message
///
class AppMessage<T extends AppMessageData> {
  final AppMessageType type;
  final T? data;

  const AppMessage(this.type, [this.data]);

  Uint8List toBytes() {
    final payload = (data?.toJson() ?? '{}').trim();
    final buffer = Uint8List(12 + payload.length);
    buffer.setRange(
        0, 8, payload.length.toString().padLeft(8, '0').trim().codeUnits);

    buffer.setRange(8, 9, '.'.codeUnits);
    buffer.setRange(
        9, 11, type.index.toString().padLeft(2, '0').trim().codeUnits);
    buffer.setRange(11, 12, '.'.codeUnits);

    final dataBytes = utf8.encode(payload.trim());
    buffer.setRange(12, 12 + dataBytes.length, dataBytes);

    // buffer.setRange(
    //     0, 3, type.index.toString().padLeft(3, '0').trim().codeUnits);
    // buffer.setRange(3, 3 + dataBytes.length, dataBytes);
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
      case AppMessageType.requestSync:
        return RequestSyncMessage.parse(dataString!);
      default:
        throw Exception('Unknown message type: $type');
    }
  }
}
