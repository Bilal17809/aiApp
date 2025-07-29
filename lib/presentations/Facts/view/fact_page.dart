import 'dart:math';
import 'package:ai_app/presentations/Ads/splash_interstitial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_app/core/theme/app_colors.dart';
import '/core/constants/constants.dart';
import '/core/routes/app_routes.dart';
import '/core/theme/app_styles.dart';
import '../../Ads/Banner/controller/banner_ad_controller.dart';
import '../../Ads/Interstitial/controller/interstitial_ad_controller.dart';
import '../controller/fact_controller.dart';

class FactPage extends StatelessWidget {
  const FactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FactController>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, value) {
        if (!didPop) {
          Get.offAllNamed(AppRoutes.home);
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: Obx(() {
          if (controller.facts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: kWhite),
            );
          }

          final currentFact = controller.facts[controller.currentPage.value];

          return Stack(
            children: [
              Positioned(
                top: -screenSize(context).width * 0.4,
                left: -screenSize(context).width * 0.2,
                child: Container(
                  width: screenSize(context).width * 1.5,
                  height: screenSize(context).width * 1.5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: skyColor,
                  ),
                ),
              ),

              // Main Content
              Column(
                children: [
                  const SizedBox(height: 80),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        currentFact.category,
                        style: headlineSmallStyle.copyWith(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: controller.onPageChanged,
                      itemCount: controller.facts.length,
                      itemBuilder: (context, index) {
                        final fact = controller.facts[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Container(
                                margin: const EdgeInsets.only(
                                  top: 50,
                                  bottom: 100,
                                ),
                                padding: const EdgeInsets.all(24),
                                decoration: roundedDecorationWithShadow
                                    .copyWith(color: Colors.white),
                                constraints: BoxConstraints(
                                  minHeight: screenSize(context).height * 0.1,
                                  maxHeight: screenSize(context).height * 0.28,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top:
                                                (screenSize(context).height) *
                                                0.08,
                                          ),
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Text(
                                              fact.fact,
                                              textAlign: TextAlign.center,
                                              style: factTextStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 12),

                                    Obx(() {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: arrowButtonDecoration,
                                            child: IconButton(
                                              onPressed:
                                                  controller.currentPage.value >
                                                          0
                                                      ? controller
                                                          .goToPreviousPage
                                                      : null,
                                              icon: const Icon(
                                                Icons.arrow_back_ios_new,
                                              ),
                                              color:
                                                  controller.currentPage.value >
                                                          0
                                                      ? kBlack
                                                      : greyColor,
                                              iconSize: 24,
                                            ),
                                          ),

                                          Container(
                                            decoration: arrowButtonDecoration,
                                            child: IconButton(
                                              onPressed:
                                                  controller.currentPage.value <
                                                          (controller
                                                                  .facts
                                                                  .length) -
                                                              1
                                                      ? controller.goToNextPage
                                                      : null,
                                              icon: const Icon(
                                                Icons.arrow_forward_ios,
                                              ),
                                              color:
                                                  controller.currentPage.value <
                                                          (controller
                                                                  .facts
                                                                  .length) -
                                                              1
                                                      ? kBlack
                                                      : greyColor,
                                              iconSize: 24,
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  Obx(() {
                    final totalDots = min(6, controller.facts.length);
                    final realIndex = controller.currentPage.value % totalDots;

                    return Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(totalDots, (dotIndex) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: realIndex == dotIndex ? 20 : 8,
                            decoration: getDotDecoration(realIndex == dotIndex),
                          );
                        }),
                      ),
                    );
                  }),
                  const SizedBox(height: 15),
                ],
              ),
            ],
          );
        }),
        bottomNavigationBar: Obx(() {
          final interstitial = Get.find<InterstitialAdController>();
          final splInter= Get.find<SplashInterstitialAdController>();
          final banner = Get.find<BannerAdController>();
          return interstitial.isShowingInterstitialAd.value
              || splInter.isShowingInterstitialAd.value
              ? const SizedBox()
              : banner.getBannerAdWidget('ad3');
        }),
      ),
    );
  }
}
