import 'package:flutter/material.dart';
import 'no_internet_dialog.dart';

void showNetworkDialog({
  required BuildContext context,
  required VoidCallback onRetry,
  String title = 'No Internet',
  String message = 'Please connect to the internet to continue.',
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => NoInternetDialog(
      onRetry: onRetry,
      title: title,
      message: message,
    ),
  );
}
