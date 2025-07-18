import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdController extends GetxController {
  late InterstitialAd _interstitialAd;
  var isAdLoaded = false.obs;


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

  void showAd() {
    if (!isAdLoaded.value) {

      return;
    }

    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        isAdLoaded.value = false;
        _loadAd(); // Load next ad
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {

        ad.dispose();
        isAdLoaded.value = false;
      },
    );

    _interstitialAd.show();
    isAdLoaded.value = false;
  }

  @override
  void onClose() {
    if (isAdLoaded.value) {
      _interstitialAd.dispose();
    }
    super.onClose();
  }
}
