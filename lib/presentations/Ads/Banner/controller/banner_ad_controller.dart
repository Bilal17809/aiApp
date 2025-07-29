import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../remove_ads_contrl/remove_ads_contrl.dart';
import '../../ad_open_App/controller/open_ad_controller.dart';

class BannerAdController extends GetxController {
  final Map<String, BannerAd> _ads = {};
  final Map<String, RxBool> _adLoaded = {};
  RxBool isAdEnabled = true.obs;
  final Map<String, AdWidget> _adWidgets = {};
  final AppOpenAdController openAdController=Get.put(AppOpenAdController());
  final RemoveAds removeAds = Get.put(RemoveAds());


  @override
  void onInit() {
    super.onInit();
    fetchRemoteConfig();
  }


  Future<void> fetchRemoteConfig() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(minutes: 1),
      ));

      await remoteConfig.fetchAndActivate();

      // Use platform-specific Remote Config key
      String bannerKey;
      if (Platform.isAndroid) {
        bannerKey = 'BannerAd';
      } else if (Platform.isIOS) {
        bannerKey = 'BannerAd';
      } else {
        throw UnsupportedError('Unsupported platform');
      }

      bool bannerAdsEnabled = remoteConfig.getBool(bannerKey);
      isAdEnabled.value = bannerAdsEnabled;

      if (bannerAdsEnabled) {
        for (int i = 1; i <= 21; i++) {
          loadBannerAd('ad$i');
        }
      }
    } catch (e) {
      print('Error fetching Remote Config: $e');
    }
  }


  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8331781061822056/4174134367';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5405847310750111/8608704402';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  void loadBannerAd(String key) {
    if (_ads.containsKey(key)) {
      _ads[key]!.dispose();
    }

    final bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _adLoaded[key] = true.obs;
          print("Banner Ad Loaded for key: $key");

          _adWidgets[key] = AdWidget(ad: ad as BannerAd);
        },
        onAdFailedToLoad: (ad, error) {
          _adLoaded[key] = false.obs;
          print("Ad failed to load for key $key: ${error.message}");
        },
      ),
    );

    _ads[key] = bannerAd;
    bannerAd.load();
  }


  @override
  void onClose() {
    for (final ad in _ads.values) {
      ad.dispose();
    }
    super.onClose();
  }

  Widget getBannerAdWidget(String key) {
    if (Platform.isIOS && removeAds.isSubscribedGet.value) {
       return SizedBox();
    }
    if (openAdController.isShowingOpenAd.value)
      return const SizedBox();

    if (isAdEnabled.value &&
        _ads.containsKey(key) &&
        _adLoaded[key]?.value == true &&
        _adWidgets.containsKey(key)) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 2),
          borderRadius: BorderRadius.circular(2),
        ),
        height: _ads[key]!.size.height.toDouble(),
        width: double.infinity,
        child: _adWidgets[key]!,
      );
    } else {
      return Shimmer.fromColors(
        baseColor: Colors.blue.shade50,
        highlightColor: bgColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      );
    }
  }
}

// class BannerAdController extends GetxController {
//   late BannerAd bannerAd;
//
//   final isAdLoaded = false.obs;
//   final isVisible = true.obs;
//
//   final String _testAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
//
//   String get adUnitId => _testAdUnitId;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadBannerAd();
//   }
//
//   void loadBannerAd() {
//     bannerAd = BannerAd(
//       adUnitId: adUnitId,
//       size: AdSize.banner,
//       request: const AdRequest(),
//       listener: BannerAdListener(
//         onAdLoaded: (Ad ad) {
//           isAdLoaded.value = true;
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           ad.dispose();
//           isAdLoaded.value = false;
//         },
//       ),
//     );
//
//     bannerAd.load();
//   }
//
//   void hideAd() {
//     isVisible.value = false;
//   }
//
//   void showAdAgain() {
//     isVisible.value = true;
//     loadBannerAd();
//   }
//
//   @override
//   void onClose() {
//     bannerAd.dispose();
//     super.onClose();
//   }
// }
