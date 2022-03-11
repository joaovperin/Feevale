import 'package:test/test.dart';

import '../bin/server/http_request.dart';

void main() {
  group('request parsing', () {
    test('GET', () {
      final input = '''GET /api/twa/game-accounts?account=2738 HTTP/1.1
      Host: tw-assistant.vercel.app
      user-agent: insomnia/2022.1.1
      accept: */*
      X-App-Custom-Header: myvalue''';

      final req = HttpRequest.parse(input);
      expect(req.version, equals('HTTP/1.1'));
      expect(req.method, equals('GET'));
      expect(req.path, equals('/api/twa/game-accounts'));
      expect(req.params, equals({'account': '2738'}));
      expect(
          req.headers,
          equals({
            'Host': 'tw-assistant.vercel.app',
            'user-agent': 'insomnia/2022.1.1',
            'accept': '*/*',
            'X-App-Custom-Header': 'myvalue',
          }));
    });
  });

  test('POST', () {
    final inputBody = '''{
      "account": "2738",
      "password": "123456"
    }''';
    final input = '''POST /api/twa/login HTTP/2
      Host: tw-assistant.vercel.app
      user-agent: insomnia/2021.7.2
      content-type: application/json
      accept: */*
      content-length: 45
      \n$inputBody''';

    final req = HttpRequest.parse(input);
    expect(req.version, equals('HTTP/2'));
    expect(req.method, equals('POST'));
    expect(req.path, equals('/api/twa/login'));
    expect(req.params, equals({}));
    expect(
        req.headers,
        equals({
          'Host': 'tw-assistant.vercel.app',
          'user-agent': 'insomnia/2021.7.2',
          'content-type': 'application/json',
          'accept': '*/*',
          'content-length': '45',
        }));
    expect(req.rawBody, equals(inputBody));
  });
}
