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

  await sendMessage(conn, MsgType.connect, {'nickname': 'foo'});

  await sendMessage(conn, MsgType.connect, {'nickname': 'bar'});

  await sendMessage(
    conn,
    MsgType.text,
    {
      'from': 'foo',
      'to': 'bar',
      'content': 'Hello!',
    },
  );

  await sendMessage(conn, MsgType.disconnect, {'nickname': 'foo'});

  await sendMessage(conn, MsgType.disconnect, {'nickname': 'bar'});

  print('Bye!');
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

  final jsonSizePart = jsonData.length.toString().padLeft(8, '0');
  final typePart = type.index.toString().padLeft(2, '0');

  final message = '$jsonSizePart.$typePart.$jsonData';
  final utf8EncodedMsg = utf8.encode(message);

  // Send 1 byte at a time to test server capabilities
  for (final b in utf8EncodedMsg) {
    conn.add([b]);
    conn.flush();
    await Future.delayed(const Duration(milliseconds: 10));
  }
  await Future.delayed(const Duration(milliseconds: 1000));
}
