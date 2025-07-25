import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdController extends GetxController with WidgetsBindingObserver {
  AppOpenAd? _appOpenAd;
  bool _isShowingopenAd = false;
  DateTime? _adLoadTime;
  bool suppressOpenAd = false;

  final Duration maxCacheDuration = Duration(hours: 4);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _loadAd();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _showAdIfAvailable();
    }
  }

  void temporarilySuppressOpenAd({
    Duration duration = const Duration(seconds: 5),
  }) {
    suppressOpenAd = true;
    Future.delayed(duration, () {
      suppressOpenAd = false;
    });
  }

  void _loadAd() {
    AppOpenAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/9257395921',
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _adLoadTime = DateTime.now();
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  bool _isAdAvailable() {
    return _appOpenAd != null &&
        _adLoadTime != null &&
        DateTime.now().difference(_adLoadTime!) < maxCacheDuration;
  }

  void _showAdIfAvailable() {
    if (!_isAdAvailable() || _isShowingopenAd || suppressOpenAd) return;

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) {
        _isShowingopenAd = true;
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingopenAd = false;
        _appOpenAd = null;
        _loadAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingopenAd = false;
        _appOpenAd = null;
        _loadAd();
      },
    );

    _appOpenAd!.show();
  }
}
