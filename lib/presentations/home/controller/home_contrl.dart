import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common_wgt/NoInternetDialog.dart';

class HomeController extends GetxController {
  bool _dialogShown = false;

  @override
  void onReady() {
    super.onReady();
    _checkInternetOnStart();
  }

  Future<void> _checkInternetOnStart() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none && !_dialogShown) {
      _dialogShown = true;
      _showNoInternetDialog();
    }
  }

  void _showNoInternetDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) => NoInternetDialog(
        onRetry: () async {
          Get.back();
          _dialogShown = false;
          await _checkInternetOnStart();
        },
      ),
    );
  }
}
