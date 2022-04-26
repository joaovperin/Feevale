import 'dart:convert';
import 'dart:io';

final List<int> _buffer = [];

Future<void> main(List<String> arguments) async {
  print('Hello world!');

  final conn = await Socket.connect('localhost', 8100);

  conn.listen((List<int> event) {
    _buffer.addAll(event);

    if (_buffer.length < 12) {
      return;
    }
    final jsonSizePart = int.parse(String.fromCharCodes(_buffer.sublist(0, 8)));
    if (_buffer.length < (jsonSizePart + 12)) {
      return;
    }

    final _messageBuffer = [..._buffer];
    _buffer.clear();
    final typePart =
        int.parse(String.fromCharCodes(_messageBuffer.sublist(9, 11)));
    final jsonMessage =
        utf8.decode(_messageBuffer.sublist(12, 12 + jsonSizePart));
    print('***-> TYPE: $typePart, $jsonMessage <-***');
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

  // print('Bye!');
  // exit(0);
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
  await Future.delayed(const Duration(milliseconds: 500));
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
