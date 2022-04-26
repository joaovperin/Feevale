import 'dart:async';

import 'package:client_app/domain/settings/app_settings.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AppSettingsProvider extends ChangeNotifier {
  static const defaultSettings = AppSettings('localhost', 8100);

  AppSettings _settings = defaultSettings;
  AppSettings get settings => _settings;

  Future<void> updateSettings(String address, int port) async {
    _settings = AppSettings(address, port);
    notifyListeners();
  }

  AppSettingsProvider.listen() {
    _settings = defaultSettings;
  }

  factory AppSettingsProvider.of(BuildContext context) =>
      Provider.of<AppSettingsProvider>(context, listen: false);
}
