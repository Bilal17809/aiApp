import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  static Future<void> checkInternet(BuildContext context) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showNoInternetDialog(context);
    }
  }

  static void showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("No Internet"),
        content: const Text("Please connect to the internet to continue."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              checkInternet(context);
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
