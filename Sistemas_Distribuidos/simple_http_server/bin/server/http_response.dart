import 'http_status.dart';

/// Represents an HTTP protocol Response.
///
/// Response example:
///
/// HTTP/2 401
/// content-type: application/json; charset=utf-8
/// content-length: 52
/// server: Vercel
///
class HttpResponse {
  final HttpStatus status;

  final Map<String, String> _headers;
  final String? rawBody;

  const HttpResponse({
    required this.status,
    required this.rawBody,
    required Map<String, String> headers,
  }) : _headers = headers;

  const HttpResponse.ok({
    Map<String, String> headers = const {
      'content-type': 'application/json; charset=utf-8',
    },
    this.rawBody,
  })  : _headers = headers,
        status = HttpStatus.ok;

  const HttpResponse.html({
    Map<String, String> headers = const {
      'content-type': 'text/html; charset=utf-8',
    },
    this.rawBody,
  })  : _headers = headers,
        status = HttpStatus.ok;

  Map<String, String> get headers => {
        ..._headers,
        'content-length': rawBody?.length.toString() ?? '0',
      };

  String get version => 'HTTP/1.1';
}
