enum HttpStatus {
  ok,
  created,
  accepted,
  noContent,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  methodNotAllowed,
  conflict,
  gone,
  unprocessableEntity,
  tooManyRequests,
  internalServerError,
  notImplemented,
  badGateway,
  serviceUnavailable,
  gatewayTimeout,
  httpVersionNotSupported
}

extension HttpStatusDescription on HttpStatus {
  String get description => _httpStatusDescriptions[this]!;
  int get code => int.parse(description.split(' ').first);
  String get message => description.split(' ').last;
}

const Map<HttpStatus, String> _httpStatusDescriptions = {
  HttpStatus.ok: '200 OK',
  HttpStatus.created: '201 Created',
  HttpStatus.accepted: '202 Accepted',
  HttpStatus.noContent: '204 No Content',
  HttpStatus.badRequest: '400 Bad Request',
  HttpStatus.unauthorized: '401 Unauthorized',
  HttpStatus.forbidden: '403 Forbidden',
  HttpStatus.notFound: '404 Not Found',
  HttpStatus.methodNotAllowed: '405 Method Not Allowed',
  HttpStatus.conflict: '409 Conflict',
  HttpStatus.gone: '410 Gone',
  HttpStatus.unprocessableEntity: '422 Unprocessable Entity',
  HttpStatus.tooManyRequests: '429 Too Many Requests',
  HttpStatus.internalServerError: '500 Internal Server Error',
  HttpStatus.notImplemented: '501 Not Implemented',
  HttpStatus.badGateway: '502 Bad Gateway',
  HttpStatus.serviceUnavailable: '503 Service Unavailable',
  HttpStatus.gatewayTimeout: '504 Gateway Timeout',
  HttpStatus.httpVersionNotSupported: '505 Http Version Not Supported'
};
