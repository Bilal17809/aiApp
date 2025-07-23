import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../ad_open_App/controller/open_ad_controller.dart';

class InterstitialAdController extends GetxController {
  InterstitialAd? _interstitialAd;
  var isAdLoaded = false.obs;
  bool hasAdShown = false;

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

  void showAdOnce() {
    if (!isAdLoaded.value || hasAdShown || _interstitialAd == null) return;
    final openAdController = Get.find<AppOpenAdController>();
    openAdController.temporarilySuppressOpenAd();

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        isAdLoaded.value = false;
        hasAdShown = false;
        _loadAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        isAdLoaded.value = false;
      },
    );

    _interstitialAd!.show();
    hasAdShown = true;
    isAdLoaded.value = false;
  }

  void resetAdFlag() {
    hasAdShown = false;
  }

  @override
  void onClose() {
    _interstitialAd?.dispose();
    super.onClose();
  }
}
