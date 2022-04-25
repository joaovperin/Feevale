import 'dart:io';

import 'app_message.dart';

class AppClient {
  final Socket socket;
  final String nickname;

  const AppClient({
    // required this.uuid,
    required this.socket,
    required this.nickname,
  });

  factory AppClient.create(Socket socket, {required String nickname}) {
    return AppClient(socket: socket, nickname: nickname);
  }

  String get addr => '${socket.remoteAddress.address}:${socket.remotePort}';
  String get describe => addr;

  void send(AppMessage msg) {
    socket.add(msg.toBytes());
    socket.flush();
  }

  void onDisconnect() {
    socket.close();
    socket.destroy();
  }
}

class AppClientRepository {
  static final instance = AppClientRepository._();
  factory AppClientRepository() => AppClientRepository.instance;
  AppClientRepository._();

  static final _allClients = <AppClient>[];

  void add(AppClient client) {
    _allClients.add(client);
  }

  void remove(AppClient client) {
    _allClients.remove(client);
  }

  List<AppClient> listClients() {
    return [..._allClients];
  }

  List<AppClient> findClientsBySocket(Socket socket) {
    return _allClients.where((client) => client.socket == socket).toList();
  }

  AppClient? findByNickname(String nickname) {
    for (final c in _allClients) {
      if (c.nickname == nickname) {
        return c;
      }
    }
    return null;
  }

  bool existsByNickname(String nickname) {
    return _allClients.any((e) => e.nickname == nickname);
  }
}
