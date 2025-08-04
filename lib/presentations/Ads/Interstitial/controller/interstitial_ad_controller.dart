import 'dart:io';
import 'dart:ui';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../remove_ads_contrl/remove_ads_contrl.dart';
import '../../ad_open_App/controller/open_ad_controller.dart';

class InterstitialAdController extends GetxController {
  InterstitialAd? _interstitialAd;
  var isAdReady = false.obs;
  int screenVisitCount = 0;
  int adTriggerCount = 3;
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

      await remoteConfig.fetchAndActivate();

      String interstitialKey;
      if (Platform.isAndroid) {
        interstitialKey = 'InterstitialAd';
      } else if (Platform.isIOS) {
        interstitialKey = 'InterstititalAd';
      } else {
        throw UnsupportedError('Unsupported platform');
      }

      if (remoteConfig.getValue(interstitialKey).source !=
          ValueSource.valueStatic) {
        adTriggerCount = remoteConfig.getInt(interstitialKey);
        print("### Remote Config: Ad Trigger Count = $adTriggerCount");
      } else {
        print("### Remote Config: Using default value.");
      }
      update();
    } catch (e) {
      print('Error fetching Remote Config: $e');
      adTriggerCount = 3;
    }
  }

  String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8331781061822056/3012547195';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5405847310750111/1176435931';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  void loadInterstitialAd() {
    if (Platform.isIOS && removeAdsController.isSubscribedGet.value) {
      return;
    }
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          isAdReady.value = true;
          update();
        },
        onAdFailedToLoad: (error) {
          print("Interstitial Ad failed to load: $error");
          isAdReady.value = false;
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (_interstitialAd != null) {
      isShowingInterstitialAd.value = true;

      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          Get.find<AppOpenAdController>().setInterstitialAdDismissed();
          screenVisitCount = 0;
          isAdReady.value = false;
          isShowingInterstitialAd.value = false;
          ad.dispose();
          loadInterstitialAd();
          update();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          screenVisitCount = 0;
          isAdReady.value = false;
          isShowingInterstitialAd.value = false;
          ad.dispose();
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

  // void showInterstitialAd() {
  //   if (_interstitialAd != null) {
  //     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //       onAdDismissedFullScreenContent: (ad) {
  //         print("### Ad Dismissed, resetting visit count.");
  //         screenVisitCount = 0;
  //         ad.dispose();
  //         isAdReady.value = false;
  //         loadInterstitialAd();
  //         update();
  //       },
  //       onAdFailedToShowFullScreenContent: (ad, error) {
  //         print("### Ad failed to show: $error");
  //         screenVisitCount = 0; // ✅ Reset on failure too
  //         ad.dispose();
  //         isAdReady.value = false;
  //         loadInterstitialAd();
  //         update();
  //       },
  //     );
  //
  //     print("### Showing Interstitial Ad.");
  //     _interstitialAd!.show();
  //     _interstitialAd = null;
  //   } else {
  //     print("### Interstitial Ad not ready.");
  //   }
  // }

  void checkAndShowAd() {
    screenVisitCount++;
    print("############## Screen Visit Count: $screenVisitCount");

    if (screenVisitCount >= adTriggerCount) {
      print("### OK");
      if (isAdReady.value) {
        showInterstitialAd();
      } else {
        print("### Interstitial Ad not ready yet.");
        screenVisitCount = 0;
      }
    }
  }

  @override
  void onClose() {
    _interstitialAd?.dispose();
    super.onClose();
  }
}


// class InterstitialAdController extends GetxController {
//   InterstitialAd? _interstitialAd;
//   var isAdLoaded = false.obs;
//   bool hasAdShown = false;
//   int _interactionCount = 0;
//
//   final String adUnitId = 'ca-app-pub-3940256099942544/1033173712';
//
//   @override
//   void onInit() {
//     super.onInit();
//     _loadAd();
//   }
//
//   void _loadAd() {
//     InterstitialAd.load(
//       adUnitId: adUnitId,
//       request: const AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (InterstitialAd ad) {
//           _interstitialAd = ad;
//           isAdLoaded.value = true;
//         },
//         onAdFailedToLoad: (LoadAdError error) {
//           isAdLoaded.value = false;
//         },
//       ),
//     );
//   }
//
//   void handleTap({required Function onNavigate}) {
//     _interactionCount++;
//
//     if (_interactionCount >= 4) {
//       _interactionCount = 0;
//       showAdThenNavigate(onNavigate);
//     } else {
//       onNavigate();
//     }
//   }
//
//   void showAdThenNavigate(Function onComplete) {
//     if (isAdLoaded.value && _interstitialAd != null) {
//       final openAdController = Get.find<AppOpenAdController>();
//       openAdController.temporarilySuppressOpenAd();
//
//       _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//         onAdDismissedFullScreenContent: (InterstitialAd ad) {
//           ad.dispose();
//           _loadAd();
//           isAdLoaded.value = false;
//           onComplete();
//         },
//         onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//           ad.dispose();
//           isAdLoaded.value = false;
//           onComplete();
//         },
//       );
//
//       _interstitialAd!.show();
//       isAdLoaded.value = false;
//     } else {
//       onComplete();
//     }
//   }
//
//   void forceShowAdAfterQuiz({required VoidCallback onComplete}) {
//     showAdThenNavigate(onComplete);
//   }
//
//   @override
//   void onClose() {
//     _interstitialAd?.dispose();
//     super.onClose();
//   }
// }
