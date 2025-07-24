import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common_wgt/no_internet_dialog.dart';
import '../../Ads/Banner/controller/banner_ad_controller.dart';

class HomeController extends GetxController {
  final BannerAdController adController = Get.put(BannerAdController());
  bool _dialogShown = false;
  final isDrawerOpen = false.obs;
  static bool _firstTime = true;


  @override
  void onReady() {
    super.onReady();
    if (_firstTime) {
      _checkInternetOnStart();
      _firstTime= false;
    }
    if (adController.isAdLoaded.value) {
      adController.bannerAd.dispose();
      adController.isAdLoaded.value = false;
    }
    _loadBannerAd();

  }
  void _loadBannerAd() {
    adController.loadBannerAd();
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
        button_text: 'Ok',
        message: 'Please connect to the internet.',
        onRetry: () async {
          Get.back();

        },
      ),
    );
  }
}
