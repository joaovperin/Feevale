import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  print('Hello world!');

  final conn = await Socket.connect('localhost', 8080);

  conn.listen((List<int> event) {
    final txt = utf8.decode(event);
    final jsonData = json.decode(txt.substring(3));
    print('***-> $jsonData <-***');
  });

  await sendMessage(conn, MsgType.connect, {'nickname': 'foo'});

  await sendMessage(conn, MsgType.connect, {'nickname': 'bar'});

  await sendMessage(
    conn,
    MsgType.text,
    {
      'from': 'foo',
      'to': 'bar',
      'content': 'FUNCIONOUUU!x',
    },
  );

  print('Bye!');
}

enum MsgType { connect, text, disconnect }

Future<void> sendMessage(
  Socket conn,
  MsgType type,
  Map<String, dynamic> data,
) async {
  final jsonData = json.encode(data);
  final message = '00${type.index}' + jsonData;
  final utf8Message = utf8.encode(message);
  conn.add(utf8Message);
  conn.flush();
  await Future.delayed(Duration(milliseconds: 1));
}
