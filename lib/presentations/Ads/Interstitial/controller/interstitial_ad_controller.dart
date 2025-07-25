import 'dart:ui';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../ad_open_App/controller/open_ad_controller.dart';

class InterstitialAdController extends GetxController {
  InterstitialAd? _interstitialAd;
  var isAdLoaded = false.obs;
  bool hasAdShown = false;
  int _interactionCount = 0;

  final String adUnitId = 'ca-app-pub-3940256099942544/1033173712';

  @override
  void onInit() {
    super.onInit();
    _loadAd();
  }

  void _loadAd() {
    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          isAdLoaded.value = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          isAdLoaded.value = false;
        },
      ),
    );
  }

  void handleTap({required Function onNavigate}) {
    _interactionCount++;

    if (_interactionCount >= 4) {
      _interactionCount = 0;
      showAdThenNavigate(onNavigate);
    } else {
      onNavigate();
    }
  }

  void showAdThenNavigate(Function onComplete) {
    if (isAdLoaded.value && _interstitialAd != null) {
      final openAdController = Get.find<AppOpenAdController>();
      openAdController.temporarilySuppressOpenAd();

      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _loadAd();
          isAdLoaded.value = false;
          onComplete();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          isAdLoaded.value = false;
          onComplete();
        },
      );

      _interstitialAd!.show();
      isAdLoaded.value = false;
    } else {
      onComplete();
    }
  }

  void forceShowAdAfterQuiz({required VoidCallback onComplete}) {
    showAdThenNavigate(onComplete);
  }

  @override
  void onClose() {
    _interstitialAd?.dispose();
    super.onClose();
  }
}
