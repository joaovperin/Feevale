import 'dart:convert';

import '../app_message.dart';

class TextMessage extends AppMessage<TextData> {
  const TextMessage(TextData data) : super(AppMessageType.text, data);

  @override
  TextData get data => super.data!;

  factory TextMessage.parse(String payload) {
    final data = TextData.fromJson(payload);
    return TextMessage(data);
  }
}

class TextData extends AppMessageData {
  final String from;
  final String to;
  final String content;
  final DateTime datetime;

  const TextData({
    required this.from,
    required this.to,
    required this.content,
    required this.datetime,
  });

  factory TextData.fromJson(String json) {
    final data = jsonDecode(json);
    return TextData(
      from: data['from'] as String,
      to: data['to'] as String,
      content: data['content'] as String,
      datetime: DateTime.now(),
    );
  }

  @override
  String toJson() {
    return json.encode({
      'from': from,
      'to': to,
      'content': content,
      'datetime': datetime.toIso8601String(),
    });
  }
}
