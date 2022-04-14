import 'dart:convert';

import '../app_message.dart';

class ConnectedMessage extends AppMessage<ConnectedData> {
  const ConnectedMessage(ConnectedData data)
      : super(AppMessageType.connected, data);

  @override
  ConnectedData get data => super.data!;

  factory ConnectedMessage.parse(String payload) {
    final data = ConnectedData.fromJson(payload);
    return ConnectedMessage(data);
  }
}

class ConnectedData extends AppMessageData {
  final String nickname;

  const ConnectedData({required this.nickname});

  factory ConnectedData.fromJson(String json) {
    final data = jsonDecode(json);
    return ConnectedData(
      nickname: data['nickname'] as String,
    );
  }

  @override
  String toJson() {
    return json.encode({
      'nickname': nickname,
    });
  }
}
