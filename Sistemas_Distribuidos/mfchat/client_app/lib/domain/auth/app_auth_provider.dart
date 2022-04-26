import 'dart:async';

import 'package:client_app/domain/app_chat.dart';
import 'package:client_app/domain/auth/app_user.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AppAuthProvider extends ChangeNotifier {
  static final StreamController<AppUser?> _userController =
      StreamController<AppUser?>.broadcast();

  AppUser? _currentLoggedUser;
  AppUser? get loggedUser => _currentLoggedUser;

  AppAuthProvider.listen() {
    _userController.stream.listen((user) {
      _currentLoggedUser = user;
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

  Future<void> loginViaNickname(
      String address, int port, String username) async {
    try {
      await AppChatRepository().connect(address, port, username);
      _userController.add(AppUser(username));
    } catch (err) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await AppChatRepository().disconnect(_currentLoggedUser!.nickname);
    _userController.add(null);
  }
}
