import 'package:client_app/application/chat_message_repository.impl.dart';

abstract class ChatMessageRepository {
  factory ChatMessageRepository() => ChatMessageRepositoryImpl.instance;

  Future<void> send(ChatMessage message);
  Future<List<ChatMessage>> firstLoad();
  Stream<ChatMessage> onMessage();
}

class ChatMessage {
  final String text;

  const ChatMessage(this.text);

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(json['text']);
  }

  Map<String, dynamic> toJson() {
    return {'text': text};
  }
}
