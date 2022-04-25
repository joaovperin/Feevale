import 'dart:async';

import 'app_exceptions.dart';

class TimeoutUtils {
  static Future<T> longPoll<T>(
    T? Function() getResponse, {
    Duration pollTime = const Duration(milliseconds: 50),
    Duration timeout = const Duration(seconds: 5),
  }) async {
    bool _timeoutReached = false;
    // Attach timer
    Future.delayed(timeout).then((value) => _timeoutReached = true);

    while (true) {
      await Future.delayed(pollTime);
      if (_timeoutReached) {
        throw TimeoutException('Timeout reached while waiting for response!');
      }
      T? response = getResponse.call();
      if (response != null) {
        return response;
      }
    }
  }
}

class TimeoutException extends AppException {
  TimeoutException(String cause) : super(cause);
}
