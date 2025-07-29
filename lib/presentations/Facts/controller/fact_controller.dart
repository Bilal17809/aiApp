import 'package:ai_app/presentations/Ads/Interstitial/controller/interstitial_ad_controller.dart';
import 'package:ai_app/presentations/Ads/splash_interstitial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_app/data/data_sources/local_fact_data.dart';
import '../../../data/models/fact_model.dart';

class FactController extends GetxController {
  final RxList<FactModel> facts = <FactModel>[].obs;
  final RxInt currentPage = 0.obs;
  final PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    loadFacts();
    Get.find<InterstitialAdController>().checkAndShowAd();
  }

  void loadFacts() async {
    final loadedFacts = await LocalFactData.loadFacts();
    loadedFacts.shuffle();
    facts.assignAll(loadedFacts);
    currentPage.value = 0;
    pageController.jumpToPage(0);
  }

  // void onPageChanged(int index) {
  //   currentPage.value = index;
  //   if(currentPage.value==5 && Get.find<SplashInterstitialAdController>().isAdReady){
  //     Get.find<SplashInterstitialAdController>().showInterstitialAd();
  //   }
  // }
  void onPageChanged(int index) {
    currentPage.value = index;

    if (index == 5) {
      final splashAdController = Get.find<SplashInterstitialAdController>();
      if (splashAdController.isAdReady) {
        splashAdController.showInterstitialAd();
      }
    }
  }


  void goToNextPage() {
    if (currentPage.value < facts.length - 1) {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.easeIn);
    }
  }

  void goToPreviousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: 300.milliseconds,
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
