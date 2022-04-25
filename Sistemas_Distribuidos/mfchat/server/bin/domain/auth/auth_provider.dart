import 'dart:async';
import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get_it/get_it.dart';
// import 'package:launcher/app_config.dart';
// import 'package:launcher/application/infra/auth/app_user.dart';
// import 'package:launcher/application/infra/misc/app_exceptions.dart';
// import 'package:logging/logging.dart';
// import 'package:provider/provider.dart';


class AppAuthProvider extends ChangeNotifier {
  static final StreamController<AppUser?> _userController =
      StreamController<AppUser?>.broadcast();

  AppUser? _currentLoggedUser;
  AppUser? get loggedUser => _currentLoggedUser;

  AppAuthProvider.listen() {
    _userController.stream.listen((user) {
      _currentLoggedUser = user;
      logger.info('logged user changed: $user');
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _currentLoggedUser = null;
    _userController.close();
    super.dispose();
  }

  factory AppAuthProvider.of(BuildContext context) =>
      Provider.of<AppAuthProvider>(context, listen: false);

  Future<void> loginViaCredentials({
    required String email,
    required String password,
  }) async {
    logger.info('Logging in via credentials');

    try {
      final result = await _dio.post(
        '${AppConfig.apiUrl}/twa/auth',
        data: {
          'email': email,
          'password': password,
          'runnerData': _getRunnerData
        },
      );
      final header = result.headers['x-twa-token'];
      _userController.add(
        AppUser(email: email, jwt: header?.first.toString()),
      );
    } catch (err) {
      if (err is DioError) {
        logger.severe('Error logging in via credentials: ${err.message}');
        final statusCode = err.response?.statusCode ?? 500;
        if (statusCode == 401) {
          throw WrongCredentialsException(email);
        } else if (statusCode == 403) {
          throw UserNotRegisteredException(email);
        }
        throw AppException(err.message);
      }
      rethrow;
    }
    logger.info('User \'$email\' logged in via credentials');
  }

  Map<String, Object> get _getRunnerData {
    // TODO(Perin): finish that (format fields if needed)
    // final osType = Platform.operatingSystem;
    // final osVersion = Platform.operatingSystemVersion;
    // final xxx = r'"Windows 10 Pro" 10.0 (Build 19043)';

    // final regexp = RegExp(r'"(\w+)" (\d+\.\d+)+ \(Build (\d+)\)');
    // final groups = regexp.firstMatch(osVersion);
    // final osVersionName = groups.group(1);

    return {
      'key': Platform.localHostname,
      'info': {
        'network': {
          'ip': '',
        },
        'os': {
          'arch': '',
          'hostname': Platform.localHostname,
          'platform': '',
          'type': Platform.operatingSystem,
          'version': Platform.operatingSystemVersion,
        }
      }
    };
  }

  Future<void> logout() async {
    logger.info('User \'${loggedUser!.email ?? "???"}\' logged out');
    _userController.add(null);
  }

  Dio get _dio => GetIt.I.get<Dio>();
}

class UserNotRegisteredException extends AppException {
  UserNotRegisteredException(String email)
      : super('The user $email is not registered!');
}

class WrongCredentialsException extends AppException {
  WrongCredentialsException(String user)
      : super('Wrong credentials for user $user! Please verify and try again.');
}
