import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color text = Color(0xFF000000);
  static const Color secondary = Color(0xFFFFFFFF);

  // // Globals
  // static final MaterialColor primarySwatch =
  //     _createMaterialColor(AppColors.primary);

  // static const Color primary = Color(0xFFFF751F);
  // static const Color secondary = Color(0xFF3B3B3B);
  // static const Color background = Color(0xFF141414);
  // static const Color border = Color(0xFFFFFFFF);
  // static const Color text = Color(0xFFFFFFFF);
  // static const Color textInverted = Color(0xFF141414);
  // static const Color textFieldValue = Color(0xFFDEDEDE);
  // static const Color textDisabled = Color(0xFF979CA0);
  // static const Color hint = Color(0xFF9E9E9E);
  // // static const Color icon = Color(0xFFFF751F);
  // static const Color icon = Color(0xFFFF751F);
  // static const Color alternativeIcon = Color(0xFFDEDEDE);

  // ...
  static const Color info = Color(0xFF64B5F6);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFD54F);
  static const Color danger = Color(0xFFF44336);
  // static const Color success = Color(0xFF4CAF50);
  // static const Color warning = Color(0xFFFFAB12);
  // static const Color danger = Color(0xFFD32F2F);

  // // Buttons
  // static const Color button = Color(0xFFFF751F);
  // static const Color buttonDisabled = Color(0xFFB55C26);
  // static const Color okButton = Color(0xFF4CAF50);
  // static const Color okButtonDisabled = Color(0xFF2E7D32);

  // // Misc
  // static const Color divider = Color(0xFF979CA0);

  // // Windows specific stuff
  // static const normal = Colors.transparent;
  // static const iconNormal = Color(0xFFFF751F);
  // static const mouseOver = Color.fromARGB(255, 97, 96, 96);
  // static const mouseDown = Color.fromARGB(255, 71, 70, 70);
  // static const iconMouseOver = Color(0xFFFF751F);
  // static const iconMouseDown = Color(0xFFB55C26);

  // static const closeIconMouseOver = Color(0xFFFFFFFF);
  // static const closeIconMouseDown = Color(0xFFFFFFFF);
  // static const closeMouseOver = Color(0xFFD32F2F);
  // static const closeMouseDown = Color(0xFFB71C1C);

  // // Game bot statuses
  // static const Color running = Color(0xFF4CAF50);
  // static const Color coopRunning = Color(0xFF1A0CB3);
  // static const Color paused = Color(0xFFFFAB12);
  // static const Color inactive = Color(0xFFD32F2F);
  // static const Color offline = Color(0xFF979CA0);
}

MaterialColor _createMaterialColor(Color color) {
  final strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (final str in strengths) {
    final double ds = 0.5 - str;
    swatch[(str * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
