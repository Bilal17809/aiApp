import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdController extends GetxController {
  late BannerAd bannerAd;

  final isAdLoaded = false.obs;
  final isVisible = true.obs;

  final String _testAdUnitId = 'ca-app-pub-3940256099942544/6300978111';

  String get adUnitId => _testAdUnitId;

  @override
  void onInit() {
    super.onInit();
    loadBannerAd();
  }

  void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          isAdLoaded.value = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          isAdLoaded.value = false;
        },
      ),
    );

    bannerAd.load();
  }

  void hideAd() {
    isVisible.value = false;
  }

  void showAdAgain() {
    isVisible.value = true;
    loadBannerAd();
  }

  @override
  void onClose() {
    bannerAd.dispose();
    super.onClose();
  }
}
