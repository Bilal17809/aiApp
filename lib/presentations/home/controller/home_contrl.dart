import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/common_wgt/no_internet_dialog.dart';
import '../../Ads/Banner/controller/banner_ad_controller.dart';

class HomeController extends GetxController {
  final BannerAdController adController = Get.put(BannerAdController());
  bool _dialogShown = false;
  final isDrawerOpen = false.obs;
  static bool _firstTime = true;

  @override
  void onInit(){
    super.onInit();
    requestTrackingPermission();
  }

  @override
  void onReady() {
    super.onReady();
    adController.loadBannerAd('ad1');
    if (_firstTime) {
      _checkInternetOnStart();
      _firstTime = false;
    }
  }

  Future<void> requestTrackingPermission() async {
    if (!Platform.isIOS) {
      return;
    }
    final trackingStatus =
    await AppTrackingTransparency.requestTrackingAuthorization();

    switch (trackingStatus) {
      case TrackingStatus.notDetermined:
        debugPrint('User has not yet decided');
        break;
      case TrackingStatus.denied:
        debugPrint('User denied tracking');
        break;
      case TrackingStatus.authorized:
        debugPrint('User granted tracking permission');
        break;
      case TrackingStatus.restricted:
        debugPrint('Tracking restricted');
        break;
      default:
        debugPrint('Unknown tracking status');
    }
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
      builder:
          (_) => NoInternetDialog(
            button_text: 'Ok',
            message: 'Please connect to the internet.',
            onRetry: () async {
              Get.back();
            },
          ),
    );
  }
}
