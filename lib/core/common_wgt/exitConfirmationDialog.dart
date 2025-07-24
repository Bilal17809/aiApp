import 'package:ai_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:flutter/services.dart';

void showExitConfirmationDialog(BuildContext context) {
  PanaraConfirmDialog.show(
    context,
    title: "Exit App?",
    message: "Are you sure you want to close the app?",
    confirmButtonText: "Yes",
    cancelButtonText: "No",
    onTapCancel: () {
      Navigator.of(context).pop();
    },
    onTapConfirm: () {
      Navigator.of(context).pop();
      Future.delayed(const Duration(milliseconds: 100), () {
        SystemNavigator.pop();
      });
    },
    panaraDialogType: PanaraDialogType.custom,
    barrierDismissible: false,
    color: skyColor,
  );
}
