import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

class BannerAdController extends GetxController {
  late BannerAd bannerAd;
  var isAdLoaded = false.obs;

  /// ✅ Your real Ad Unit ID from AdMob
  final String realAdUnitId = 'ca-app-pub-9147322774066422/4288161923';

  /// ✅ Official test Banner Ad Unit from Google
  final String testAdUnitId = 'ca-app-pub-3940256099942544/6300978111';

  /// ✅ Switch based on debug/release mode
  String get adUnitId => kReleaseMode ? realAdUnitId : testAdUnitId;

  @override
  void onInit() {
    super.onInit();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          isAdLoaded.value = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();

        },
      ),
      request: const AdRequest(),
    );

    bannerAd.load();
  }

  @override
  void onClose() {
    bannerAd.dispose();
    super.onClose();
  }
}
