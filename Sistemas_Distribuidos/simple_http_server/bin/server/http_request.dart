import 'dart:typed_data';

/// Represents an HTTP protocol Request.
///
/// GET request example:
///
/// GET /api/game-accounts?account=2738 HTTP/1.1
/// Host: my-host.name.com
/// user-agent: insomnia/2022.1.1
/// accept: */*
///
/// POST request example:
///
/// POST /api/login HTTP/2.0
/// Host: my-host.name.com
/// user-agent: insomnia/2021.7.2
/// content-type: application/json
/// accept: */*
/// content-length: 97
///
/// {
/// 	"user": "pA6jPXFNRy0qtt2pdqtD",
/// 	"password": "epiecXdV0PE8aDgj4Fjs"
/// }
///
class HttpRequest {
  final String method;
  final String path;
  final String version;
  final Map<String, String> headers;
  final Map<String, String> params;
  final String? rawBody;

  const HttpRequest({
    required this.method,
    required this.path,
    required this.version,
    required this.headers,
    required this.params,
    required this.rawBody,
  });

  factory HttpRequest.parseBytes(Uint8List rawBytes) => HttpRequest.parse(
        String.fromCharCodes(rawBytes),
      );

  factory HttpRequest.parse(String rawRequest) {
    final List<String> rawRequestLines = rawRequest.split('\n');

    final Map<String, String> params = {};
    final Map<String, String> headers = {};
    String? rawBody;
    String? strQueryParams;

    final String firstLine = rawRequestLines.first;
    final List<String> firstLineParts = firstLine.split(' ');
    final String method = firstLineParts[0].toUpperCase();
    final String fullPath = firstLineParts[1];
    final String version = firstLineParts[2];

    final List<String> arrPath = fullPath.split('?');
    if (arrPath.length == 2) {
      strQueryParams = arrPath.last;
    } else if (arrPath.length > 2) {
      throw 'Failed to parse request path: $fullPath';
    }

    // REQUEST PATH
    final String path = arrPath.first;

    // REQUEST QUERY PARAMS
    if (strQueryParams != null) {
      final rawQueryParams = strQueryParams.split('&');
      for (final rawQueryParam in rawQueryParams) {
        final List<String> arrQueryParam = rawQueryParam.split('=');
        if (arrQueryParam.length > 2) {
          throw 'Failed to parse query param: $rawQueryParam';
        }

        final String key = arrQueryParam.first;
        final String value = arrQueryParam.last;
        params[key] = value;
      }
    }

    // REQUEST headers
    int idx = 1;
    for (idx = 1; idx < rawRequestLines.length; idx++) {
      final String rawHeaderLine = rawRequestLines[idx].trim();
      // End of headers and start of body
      if (rawHeaderLine.isEmpty) {
        break;
      }
      final List<String> headerParts = rawHeaderLine.split(':');
      if (headerParts.length != 2) {
        throw 'Failed to parse header line: $rawHeaderLine';
      }

      final String headerName = headerParts[0].trim();
      final String headerValue = headerParts[1].trim();

      final _lowerCaseHeaderName = headerName.toLowerCase();
      if (_lowerCaseHeaderName.startsWith("x-")) {
        headers[headerName] = headerValue;
      } else if (_knownHeaders.contains(_lowerCaseHeaderName)) {
        headers[headerName] = headerValue;
      }
    }

    // REQUEST BODY
    if (idx < rawRequestLines.length) {
      final List<String> rawBodyLines = rawRequestLines.sublist(idx + 1);
      rawBody = rawBodyLines.join('\n');
    }

    return HttpRequest(
      method: method,
      path: path,
      version: version,
      headers: headers,
      params: params,
      rawBody: rawBody,
    );
  }

  String fmtBeauty() {
    return '''
    method: $method
    path: $path
    version: $version
    headers: $headers
    params: $params
    rawBody: $rawBody
    ''';
  }
}

const _knownHeaders = [
  'content-type',
  'content-length',
  'accept',
  'user-agent',
  'host',
  'accept-encoding',
  'accept-language',
  'accept-charset',
  'cookie',
  'authorization',
  'if-modified-since',
  'if-none-match',
  'referer',
  'origin',
];
