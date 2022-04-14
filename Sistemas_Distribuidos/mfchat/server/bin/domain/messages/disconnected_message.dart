import 'dart:convert';

import '../app_message.dart';

class DisconnectedMessage extends AppMessage<DisconnectedData> {
  const DisconnectedMessage(DisconnectedData data)
      : super(AppMessageType.connected, data);

  @override
  DisconnectedData get data => super.data!;

  factory DisconnectedMessage.parse(String payload) {
    final data = DisconnectedData.fromJson(payload);
    return DisconnectedMessage(data);
  }
}

class DisconnectedData extends AppMessageData {
  final String nickname;

  const DisconnectedData({required this.nickname});

  factory DisconnectedData.fromJson(String json) {
    final data = jsonDecode(json);
    return DisconnectedData(
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
