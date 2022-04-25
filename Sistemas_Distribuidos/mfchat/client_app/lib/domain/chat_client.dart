import 'package:client_app/application/chat_client_repository.impl.dart';

abstract class ChatClientRepository {
  factory ChatClientRepository() => ChatClientRepositoryImpl.instance;

  Future<List<ChatClient>> firstLoad();
  Stream<ChatClient> onClientConnected();
}

class ChatClient {
  final String nickname;

  const ChatClient({
    required this.nickname,
  });
}
