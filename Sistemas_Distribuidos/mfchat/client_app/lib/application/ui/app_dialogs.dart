import 'dart:async';

import 'package:client_app/commons/app_colors.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  /// Shows a confirmation dialog on the [context] with the [richText] [RichText]
  static Future<bool> richConfirm(BuildContext context, RichText richText,
      {required DialogActionsType elevated}) async {
    final clickResponse = await AppDialogs.general(
      dialogType: DialogType.confirm,
      context: context,
      title: 'Confirm',
      content: richText,
      dialogActions: [DialogActionsType.yes, DialogActionsType.no],
      elevated: [elevated],
    );
    return clickResponse == DialogActionsType.yes;
  }

  /// Shows a confirmation dialog on the [context] with the [text] [Widget]
  static Future<bool> confirm(BuildContext context, String text,
      {required DialogActionsType elevated}) async {
    final clickResponse = await AppDialogs.general(
      dialogType: DialogType.confirm,
      context: context,
      title: 'Confirm',
      content: Text(text, style: const TextStyle(color: AppColors.text)),
      dialogActions: [DialogActionsType.no, DialogActionsType.yes],
      elevated: [elevated],
    );
    return clickResponse == DialogActionsType.yes;
  }

  /// Shows a loader/progress indicator in a dialog on the [context] with the [message]
  static Completer loading(BuildContext context, {String? message}) {
    final completer = Completer();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // Fecha o dialog quando o chamador invocar o método .complete()
        completer.future.whenComplete(() {
          Navigator.of(context).pop();
        });
        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(message ?? 'await...',
                      style: const TextStyle(
                          fontSize: 24 /*,color: AppColors.text */)),
                  const SizedBox(height: 40),
                  const CircularProgressIndicator(),
                ],
              )
            ],
          ),
        );
      },
    );
    return completer;
  }

  /// Shows a warning dialog with the [child] OR the [message] provided.
  static Future<void> error(
    BuildContext context, {
    Widget? child,
    String? message,
  }) async {
    const valMessage =
        'Please provide either "child", or "message"! Not both!!';
    assert(child != null || message != null, valMessage);
    assert(child == null || message == null, valMessage);
    await AppDialogs.general(
      dialogType: DialogType.error,
      context: context,
      title: 'Error',
      content: child ??
          Text(message!,
              style: const TextStyle(fontSize: 16, color: AppColors.text)),
      dialogActions: [DialogActionsType.ok],
      elevated: [DialogActionsType.ok],
    );
  }

  /// Shows a warning dialog with the [child] OR the [message] provided.
  static Future<void> warning(
    BuildContext context, {
    Widget? child,
    String? message,
  }) async {
    const valMessage =
        'Please provide either "child", or "message"! Not both!!';
    assert(child != null || message != null, valMessage);
    assert(child == null || message == null, valMessage);
    await AppDialogs.general(
      dialogType: DialogType.warning,
      context: context,
      title: 'Warning',
      content: child ??
          Text(message!,
              style: const TextStyle(fontSize: 16, color: AppColors.text)),
      dialogActions: [DialogActionsType.ok],
      elevated: [DialogActionsType.ok],
    );
  }

  /// Shows an information dialog with the [child] OR the [message] provided.
  static Future<void> information(
    BuildContext context, {
    Widget? child,
    String? message,
  }) async {
    const valMessage =
        'Please provide either "child", or "message"! Not both!!';
    assert(child != null || message != null, valMessage);
    assert(child == null || message == null, valMessage);
    await AppDialogs.general(
      dialogType: DialogType.info,
      context: context,
      title: 'Information',
      content: child ??
          Text(message!, style: const TextStyle(color: AppColors.text)),
      dialogActions: [DialogActionsType.ok],
      elevated: [DialogActionsType.ok],
    );
  }

  /// Shows a general dialog on the [context] with the [title] and desired [content], which will be dynamic according to who calls.
  /// ...it'll return an [DialogActionsType]
  static Future<DialogActionsType> general({
    required DialogType dialogType,
    required BuildContext context,
    required String title,
    required Widget content,
    required List<DialogActionsType> dialogActions,
    List<DialogActionsType> elevated = const [],
  }) async {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.secondary,
        title: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildDialogIcon(dialogType),
                const SizedBox(width: 6),
                Text(title,
                    style:
                        const TextStyle(fontSize: 20, color: AppColors.text)),
              ],
            ),
          ],
        ),
        content: content,
        actions: _buildActions(
            context: context, dialogActions: dialogActions, elevated: elevated),
      ),
    );
    return result ?? DialogActionsType.cancel;
  }
}

/// Returns the button list for the [context] according to the defined [dialogActions]
List<Widget> _buildActions({
  required BuildContext context,
  required List<DialogActionsType> dialogActions,
  required List<DialogActionsType> elevated,
}) {
  return dialogActions
      .map(
        (action) => _getAppDialogsServiceAction(context, action,
            elevated: elevated.contains(action)),
      )
      .toList();
}

/// Associates an [Icon] to be shown for a specific [DialogType]
Icon _buildDialogIcon(DialogType type) {
  switch (type) {
    case DialogType.warning:
      return const Icon(Icons.warning_amber_outlined, color: AppColors.warning);
    case DialogType.info:
      return const Icon(Icons.info_outline, color: AppColors.info);
    case DialogType.confirm:
      return const Icon(Icons.check_circle_outline, color: AppColors.success);
    case DialogType.error:
      return const Icon(Icons.sentiment_dissatisfied_outlined,
          color: AppColors.danger);
  }
}

/// Returns the button for the [context] according to the [dialogActionsType]
Widget _getAppDialogsServiceAction(
    BuildContext context, DialogActionsType dialogActionsType,
    {bool elevated = false}) {
  // Map que relaciona o dialogActionsType com o botão que será retornado
  switch (dialogActionsType) {
    case DialogActionsType.save:
      return _createAppButton(
          context: context,
          text: 'Save',
          action: dialogActionsType,
          elevated: elevated);
    case DialogActionsType.ok:
      return _createAppButton(
          context: context,
          text: 'OK',
          action: dialogActionsType,
          elevated: elevated);
    case DialogActionsType.yes:
      return _createAppButton(
          context: context,
          text: 'Yes',
          action: dialogActionsType,
          elevated: elevated);
    case DialogActionsType.no:
      return _createAppButton(
          context: context,
          text: 'No',
          action: dialogActionsType,
          elevated: elevated);
    case DialogActionsType.cancel:
      return _createAppButton(
          context: context,
          text: 'Cancel',
          action: dialogActionsType,
          elevated: elevated);
  }
}

/// Defines every valid [Dialog] type
enum DialogType {
  warning,
  info,
  confirm,
  error,
}

/// Defines every valid [DialogActionsType] type
enum DialogActionsType {
  ok,
  yes,
  save,
  no,
  cancel,
}

/// onPressed function to returns button response
void _popWithResponse(context, response) => Navigator.of(context).pop(response);

/// Helper to create consistent app dialog buttons
Widget _createAppButton(
    {required BuildContext context,
    required String text,
    required DialogActionsType action,
    bool elevated = false}) {
  return elevated
      ? ElevatedButton(
          autofocus: true,
          child: Text(text),
          onPressed: () => _popWithResponse(context, action))
      : TextButton(
          child: Text(text),
          onPressed: () => _popWithResponse(context, action));
}
