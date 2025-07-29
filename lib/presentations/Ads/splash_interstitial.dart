import 'dart:io';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../remove_ads_contrl/remove_ads_contrl.dart';
import 'ad_open_App/controller/open_ad_controller.dart';

class SplashInterstitialAdController extends GetxController {
  InterstitialAd? _interstitialAd;
  bool isAdReady = false;
  bool showSplashAd = true;
  var isShowingInterstitialAd = false.obs;
  final RemoveAds removeAdsController = Get.put(RemoveAds());


  @override
  void onInit() {
    super.onInit();
    initializeRemoteConfig();
    loadInterstitialAd();
  }

  Future<void> initializeRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 1),
        ),
      );
      String interstitialKey;
      if (Platform.isAndroid) {
        interstitialKey = 'SplashInterstitial';
      } else if (Platform.isIOS) {
        interstitialKey = 'SplashInterstitial';
      } else {
        throw UnsupportedError('Unsupported platform');
      }
      await remoteConfig.fetchAndActivate();
      showSplashAd = remoteConfig.getBool(interstitialKey);
      print(
        "#################### Remote Config: Show Splash Ad = $showSplashAd",
      );
      update();
    } catch (e) {
      print('Error fetching Remote Config: $e');
      showSplashAd = false;
    }
  }

  String get spInterstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8331781061822056/2179027427';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5405847310750111/8863354264';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  void loadInterstitialAd() {
    if (Platform.isIOS && removeAdsController.isSubscribedGet.value) {
      return;
    }
    InterstitialAd.load(
      adUnitId: spInterstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          isAdReady = true;
          update();
        },
        onAdFailedToLoad: (error) {
          print("Interstitial Ad failed to load: $error");
          isAdReady = false;
        },
      ),
    );
  }
  Future<void> showInterstitialAdWhen({VoidCallback? onAdClosed}) async {
    if (!showSplashAd) {
      print("### Splash Ad Disabled via Remote Config");
      onAdClosed?.call();
      return;
    }

    if (_interstitialAd != null) {
      isShowingInterstitialAd.value = true;

      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          print("### Ad Dismissed");
          Get.find<AppOpenAdController>().setInterstitialAdDismissed();
          ad.dispose();
          _interstitialAd = null;
          isAdReady = false;
          isShowingInterstitialAd.value = false;
          loadInterstitialAd();
          update();
          onAdClosed?.call();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print("### Ad failed to show: $error");
          Get.find<AppOpenAdController>().setInterstitialAdDismissed();
          ad.dispose();
          _interstitialAd = null;
          isAdReady = false;
          isShowingInterstitialAd.value = false;
          loadInterstitialAd();
          update();
          onAdClosed?.call();  // fallback
        },
      );

      _interstitialAd!.show();
    } else {
      print("### Interstitial Ad not ready.");
      onAdClosed?.call(); // fallback if ad isn't ready
    }
  }

  Future<void> showInterstitialAd() async {
    if (!showSplashAd) {
      print("### Splash Ad Disabled via Remote Config");
      return;
    }
    if (_interstitialAd != null) {
      isShowingInterstitialAd.value = true;
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          print("### Ad Dismissed");
          Get.find<AppOpenAdController>().setInterstitialAdDismissed();
          ad.dispose();
          isAdReady = false;
          isShowingInterstitialAd.value = false;
          loadInterstitialAd();
          update();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print("### Ad failed to show: $error");
          ad.dispose();
          isAdReady = false;
          isShowingInterstitialAd.value = false;
          loadInterstitialAd();
          update();
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    } else {
      print("### Interstitial Ad not ready.");
    }
  }

  @override
  void onClose() {
    _interstitialAd?.dispose();
    super.onClose();
  }
}
