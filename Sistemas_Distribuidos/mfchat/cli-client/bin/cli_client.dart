import 'dart:convert';
import 'dart:io';

final List<int> _buffer = [];

// const defaultHostname = 'localhost';
const defaultHostname = 'ec2-54-200-151-219.us-west-2.compute.amazonaws.com';
const defaultPort = 8100;

Future<void> main(List<String> arguments) async {
  print('Hello world!');

  String hostname = defaultHostname;
  int port = defaultPort;
  if (arguments.isNotEmpty) {
    hostname = arguments[0].trim();
    if (arguments.length > 1) {
      port = int.parse(arguments[1]);
    }
  }

  final conn = await Socket.connect(hostname, port);

  conn.listen((List<int> event) {
    _buffer.addAll(event);

    try {
      if (_buffer.length < 12) {
        return;
      }

      print('->>>>>>>>>>>>>>>>>>>>> Buffer: ${String.fromCharCodes(_buffer)}');

      final sizeStr = String.fromCharCodes(_buffer.sublist(0, 8));
      final jsonSizePart = int.tryParse(sizeStr);
      if (jsonSizePart == null) {
        print('Invalid size');
        return;
      }

      if (_buffer.length < (jsonSizePart + 12)) {
        return;
      }

      final _messageBuffer = [..._buffer];
      _buffer.clear();

      final type = String.fromCharCodes(_messageBuffer.sublist(9, 11));

      final typePart = int.tryParse(type);
      if (typePart == null) {
        print('Invalid type');
        return;
      }

      final jsonMessage =
          utf8.decode(_messageBuffer.sublist(12, 12 + jsonSizePart));
      print('<-*** TYPE: $typePart, $jsonMessage <-***');
    } catch (err) {
      print('ERRO: $err');
    }
  }, onDone: () {
    print('Connection closed');
  }, onError: (err, stack) {
    print('ERRO: $err');
    print('Stack: $stack');
  });

  await sendMessage(conn, MsgType.connect, {'nickname': 'joão'});
  await sendMessage(conn, MsgType.connect, {'nickname': 'perin'});
  await sendMessage(conn, MsgType.connect, {'nickname': 'mariazinha'});
  await sendMessage(conn, MsgType.connect, {'nickname': 'julia'});
  await sendMessage(conn, MsgType.connect, {'nickname': 'carlos'});
  await sendMessage(conn, MsgType.connect, {'nickname': 'estéfani'});
  await sendMessage(conn, MsgType.connect, {'nickname': 'eduardo'});

  await sendMessage(
    conn,
    MsgType.text,
    {'from': 'eduardo', 'to': 'all', 'content': 'Oi galerinha!'},
  );

  await sendMessage(conn, MsgType.connect, {'nickname': 'fulana'});
  await sendMessage(conn, MsgType.connect, {'nickname': 'alana'});

  await sendMessage(
    conn,
    MsgType.text,
    {'from': 'alana', 'to': 'joao', 'content': 'Oii cara :D'},
  );

  await sendMessage(conn, MsgType.connect, {'nickname': 'roberto'});

  await sendMessage(
    conn,
    MsgType.text,
    {
      'from': 'alana',
      'to': 'joaovperin',
      'content': 'boa noite !!! tudo certo?'
    },
  );

  await sendMessage(conn, MsgType.connect, {'nickname': 'judite'});
  await sendMessage(conn, MsgType.connect, {'nickname': 'afonso'});
  await sendMessage(conn, MsgType.connect, {'nickname': 'andreia'});
  await sendMessage(conn, MsgType.connect, {'nickname': 'foo'});
  await sendMessage(conn, MsgType.connect, {'nickname': 'bar'});

  await sendMessage(
    conn,
    MsgType.text,
    {
      'from': 'foo',
      'to': 'all',
      'content': 'Hello!',
    },
  );

  await sendMessage(conn, MsgType.disconnect, {'nickname': 'foo'});

  await sendMessage(conn, MsgType.disconnect, {'nickname': 'bar'});

  await sendMessage(conn, MsgType.disconnect, {'nickname': 'alana'});

  print('Bye!');
  conn.destroy();
  exit(0);
}

enum MsgType { connect, text, disconnect }

// Future<void> sendMessage(
//   Socket conn,
//   MsgType type,
//   Map<String, dynamic> data,
// ) async {
//   final jsonData = json.encode(data);
//   final message = '00${type.index}' + jsonData;
//   final utf8Message = utf8.encode(message);
//   conn.add(utf8Message);
//   conn.flush();
//   await Future.delayed(Duration(milliseconds: 1));
// }

Future<void> sendMessage(
  Socket conn,
  MsgType type,
  Map<String, dynamic> data,
) async {
  print('***-> RUN: ${type.name} ${data.toString()}');
  final jsonData = json.encode(data);
  final encodedJsonData = utf8.encode(jsonData);

  final jsonSizePart = encodedJsonData.length.toString().padLeft(8, '0');
  final typePart = type.index.toString().padLeft(2, '0');

  conn.add(utf8.encode('$jsonSizePart.$typePart.') + encodedJsonData);
  conn.flush();

  // Send 1 byte at a time to test server capabilities
  // for (final b in utf8EncodedMsg) {
  //   conn.add([b]);
  //   conn.flush();
  //   await Future.delayed(const Duration(milliseconds: 10));
  // }
  await Future.delayed(const Duration(milliseconds: 120));
}
// Future<void> sendMessage(
//   Socket conn,
//   MsgType type,
//   Map<String, dynamic> data,
// ) async {
//   final jsonData = json.encode(data);

//   final jsonSizePart = jsonData.length.toString().padLeft(8, '0');
//   final typePart = type.index.toString().padLeft(2, '0');

//   final message = '$jsonSizePart.$typePart.$jsonData';
//   final utf8EncodedMsg = utf8.encode(message);
//   conn.add(utf8EncodedMsg);
//   conn.flush();

//   // Send 1 byte at a time to test server capabilities
//   // for (final b in utf8EncodedMsg) {
//   //   conn.add([b]);
//   //   conn.flush();
//   //   await Future.delayed(const Duration(milliseconds: 10));
//   // }
//   await Future.delayed(const Duration(milliseconds: 500));
// }
