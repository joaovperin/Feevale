import 'dart:io';

import 'dart:typed_data';

class AppServer {
  AppServer(this.port);

  final int port;
  late ServerSocket socketServer;

  void listen() {
    print('Server listening at port $port!');

    ServerSocket.bind(InternetAddress.anyIPv4, port)
        .then((ServerSocket server) {
      socketServer = server;
      socketServer.listen(
        _onConnection,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: false,
      );
    });
  }

  void _onConnection(Socket connection) {
    connection.listen((Uint8List data) {
      final strInput = String.fromCharCodes(data);
      final firstLine = strInput.substring(0, strInput.indexOf('\n'));
      String? body;
      
      try {
        body = strInput.substring(strInput.indexOf('\n'), strInput.indexOf('\n\n'));
      } catch (err){}

      if (firstLine.startsWith("GET") && firstLine.contains("HTTP")) {
        connection.add(Uint8List.fromList('''HTTP/1.1 200 OK
        Date: Mon, 07 Mar 2022 21:52:31 GMT
        Content-Type: text/html
        Server: myservername

        <!doctype html><html><body>Hello :D your body = $body</body></html>
        '''
            .codeUnits));
      } else {
        connection.add(Uint8List.fromList('''HTTP/1.1 405 METHOD_NOT_ALLOWED
        Date: Mon, 07 Mar 2022 21:52:31 GMT
        Content-Type: application/json
        Server: myservername

        {"error": "invalid method"}
        '''
            .codeUnits));
      }
      connection.close();
      // var outputAsUint8List = new Uint8List.fromList(s.codeUnits);
    });
  }

  void _onError(dynamic data) {
    print('Error: $data');
  }

  void _onDone() {
    print('Done !');
  }
}
