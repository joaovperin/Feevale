import 'dart:io';

const port = 8080;
final _allClients = <ConnectedClient>[];

Future<void> main(List<String> arguments) async {
  print('Trying to start server at port $port....');

  final server =
      await ServerSocket.bind(InternetAddress.anyIPv4, 8080, shared: true);

  server.listen((Socket socket) {
    _allClients.add(ConnectedClient(socket)..listen());
  });

  print('Server started!');
}

class ConnectedClient {
  final Socket socket;

  const ConnectedClient(this.socket);

  void listen() {
    socket.listen((data) {
      print('Received data: ${String.fromCharCodes(data)}');
      _sendMessage();
      // _sendMessage('Hello from server!');
    });
  }

  void _sendMessage() {
    socket.write('HTTP/1.1 200 OK\n\nHello, world!\n');
    socket.close();
  }

  void _shutdown() {
    socket.close();
    socket.destroy();
  }
}
