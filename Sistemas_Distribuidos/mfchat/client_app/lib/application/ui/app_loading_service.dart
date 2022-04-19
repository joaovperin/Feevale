import 'package:flutter/material.dart';

class AppLoadingController {
  final Future<void> Function() _onClose;

  const AppLoadingController({
    required onClose,
  }) : _onClose = onClose;

  Future<void> close() => _onClose.call();
}

class AppLoading {
  ///
  /// Shows a loading app bar
  ///
  static AppLoadingController show(BuildContext rootContext) {
    // Closes the loading dialog when the future completes
    final _loadingCompleter = AppLoadingController(
      onClose: () async {
        Navigator.of(rootContext).pop();
        return Future.delayed(const Duration(milliseconds: 100));
      },
    );

    showDialog(
        context: rootContext,
        barrierDismissible: false,
        builder: (context) => const AppLoadingIndicator());

    return _loadingCompleter;
  }
}

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
