import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

enum NativeAdSizeType { small, medium, custom }

class NativeAdController extends GetxController {
  late final BannerAd _bannerAd;
  final isLoaded = false.obs;

  final NativeAdSizeType sizeType;
  final double? customHeight;

  NativeAdController({
    this.sizeType = NativeAdSizeType.medium,
    this.customHeight,
  });

  AdSize get adSize {
    switch (sizeType) {
      case NativeAdSizeType.small:
        return AdSize.banner; // 320x50
      case NativeAdSizeType.medium:
        return AdSize.mediumRectangle; // 320x100
      case NativeAdSizeType.custom:
        return AdSize(height: (customHeight ?? 250).toInt(), width: 320);
    }
  }

  BannerAd get bannerAd => _bannerAd;

  @override
  void onInit() {
    super.onInit();

    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => isLoaded.value = true,
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void onClose() {
    _bannerAd.dispose();
    super.onClose();
  }
}
