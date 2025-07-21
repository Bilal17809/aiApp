import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdController extends GetxController {
  InterstitialAd? _interstitialAd;
  var isAdLoaded = false.obs;
  bool hasAdShown = false; // ✅ Prevent repeat showing

  final String adUnitId = 'ca-app-pub-3940256099942544/1033173712'; // ✅ test ad

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

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        isAdLoaded.value = false;
        _loadAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        isAdLoaded.value = false;
      },
    );

    _interstitialAd!.show();
    hasAdShown = true; // ✅ Prevent future shows
    isAdLoaded.value = false;
  }

  void resetAdFlag() {
    hasAdShown = false; // Call this if you want to show ad again later
  }

  @override
  void onClose() {
    _interstitialAd?.dispose();
    super.onClose();
  }
}
