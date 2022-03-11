import 'package:test/test.dart';

import '../bin/server/http_status.dart';

void main() {
  group('http status', () {
    test('Description', () {
      expect(HttpStatus.ok.description, equals('200 OK'));
      expect(HttpStatus.badRequest.description, equals('400 Bad Request'));
      expect(HttpStatus.notFound.description, equals('404 Not Found'));
      expect(HttpStatus.internalServerError.description,
          equals('500 Internal Server Error'));
    });
    test('Code', () {
      expect(HttpStatus.ok.code, equals(200));
      expect(HttpStatus.badRequest.code, equals(400));
      expect(HttpStatus.notFound.code, equals(404));
      expect(HttpStatus.internalServerError.code, equals(500));
    });
    test('Message', () {
      expect(HttpStatus.ok.message, equals('OK'));
      expect(HttpStatus.badRequest.message, equals('Bad Request'));
      expect(HttpStatus.notFound.message, equals('Not Found'));
      expect(HttpStatus.internalServerError.message,
          equals('Internal Server Error'));
    });
  });
}
