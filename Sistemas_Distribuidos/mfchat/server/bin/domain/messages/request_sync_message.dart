import 'dart:convert';

import '../app_message.dart';

class RequestSyncMessage extends AppMessage<RequestSyncData> {
  const RequestSyncMessage(RequestSyncData data)
      : super(AppMessageType.connected, data);

  @override
  RequestSyncData get data => super.data!;

  factory RequestSyncMessage.parse(String payload) {
    final data = RequestSyncData.fromJson(payload);
    return RequestSyncMessage(data);
  }
}

class RequestSyncData extends AppMessageData {
  final String nickname;

  const RequestSyncData({required this.nickname});

  factory RequestSyncData.fromJson(String json) {
    final data = jsonDecode(json);
    return RequestSyncData(
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
