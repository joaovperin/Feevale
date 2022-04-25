/// Generic app error
class AppException extends _AppBaseException {
  AppException(String cause) : super(cause);
}

/// Base exception to be extended for all app errors
abstract class _AppBaseException implements Exception {
  /// Who caused the error
  final String? cause;
  String? get message => cause;
  bool get hasMessage => cause != null;

  const _AppBaseException(this.cause);

  @override
  String toString() {
    if (cause == null) return '($runtimeType)';
    return '$cause ($runtimeType)';
  }
}
