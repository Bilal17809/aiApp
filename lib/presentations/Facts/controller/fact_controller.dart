import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_app/data/data_sources/local_fact_data.dart';
import '../../../data/models/fact_model.dart';
import '../../Ads/Banner/controller/banner_ad_controller.dart';
import '../../Ads/Interstitial/controller/interstitial_ad_controller.dart';

class FactController extends GetxController {
  final RxList<FactModel> facts = <FactModel>[].obs;
  final RxInt currentPage = 0.obs;
  final PageController pageController = PageController();

  late final BannerAdController bannerAdController;
  final int adTriggerInteractionCount = 5;
  int interactionCount = 0;

  @override
  void onInit() {
    super.onInit();
    loadFacts();

    bannerAdController = Get.put(BannerAdController(), permanent: true);
    bannerAdController.loadBannerAd();
  }

  void loadFacts() async {
    final loadedFacts = await LocalFactData.loadFacts();
    loadedFacts.shuffle();
    facts.assignAll(loadedFacts);
    currentPage.value = 0;
    pageController.jumpToPage(0);
  }

  void onPageChanged(int index) {
    currentPage.value = index;
    _handleInteraction();
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

  void _handleInteraction() async {
    interactionCount++;

    if (interactionCount >= adTriggerInteractionCount) {
      interactionCount = 0;
      bannerAdController.hideAd();
      final interstitialAdController = Get.find<InterstitialAdController>();
      interstitialAdController.showAdThenNavigate(() {
        bannerAdController.showAdAgain();
      });
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
