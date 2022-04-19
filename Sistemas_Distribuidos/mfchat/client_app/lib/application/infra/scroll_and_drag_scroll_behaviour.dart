import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScrollAndDragScrollBehavior extends MaterialScrollBehavior {
  const ScrollAndDragScrollBehavior() : super();

  static ScrollConfiguration config({required Widget child}) {
    return ScrollConfiguration(
      behavior: const ScrollAndDragScrollBehavior(),
      child: child,
    );
  }

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
