import 'package:ai_app/data/data_sources/local_fact_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/fact_model.dart';

class FactController extends GetxController {
  final RxList<FactModel> facts = <FactModel>[].obs;
  final RxInt currentPage = 0.obs;


  final PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    loadFacts();
  }

  // void loadFacts() async {
  //   final loadedFacts = await LocalFactData.loadFacts();
  //   facts.assignAll(loadedFacts);
  // }
  void loadFacts() async {
    final loadedFacts = await LocalFactData.loadFacts();
    loadedFacts.shuffle();
    facts.assignAll(loadedFacts);
    currentPage.value = 0;
    pageController.jumpToPage(0);
  }


  void onPageChanged(int index) {
    currentPage.value = index;
  }


  void goToNextPage() {
    if (currentPage.value < facts.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void goToPreviousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
