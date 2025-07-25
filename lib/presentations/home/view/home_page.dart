import 'dart:ui';
import 'package:ai_app/core/constants/constants.dart';
import 'package:ai_app/presentations/pages.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import '../../../core/common_wgt/exitConfirmationDialog.dart';
import '../../../core/common_wgt/shimmer_ad_placeholder.dart';
import '../../../core/routes/app_routes.dart';
import '../../Ads/Interstitial/controller/interstitial_ad_controller.dart';
import '../../Drawer/view/customdrawer.dart';
import '../../home/controller/home_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common_wgt/bottom_curve_clipper.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../quiz_screen/view/quiz_screen.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final interstitialAdController = Get.find<InterstitialAdController>();
    final controller = Get.find<HomeController>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, value) {
        if (!didPop) {
          if (controller.isDrawerOpen.value) {
            Get.back();
          } else {
            showExitConfirmationDialog(context);
          }
        }
      },
      child: Scaffold(
        drawer: const CustomDrawer(),
        onDrawerChanged: (isOpen) {
          controller.isDrawerOpen.value = isOpen;
        },
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                height: mobileHeight(context) * 0.45,
                color: skyColor,
                child: Stack(
                  children: [
                    Positioned(
                      left: mobileWidth(context) * 0.01,
                      top: mobileHeight(context) * 0.06,
                      child: Builder(
                        builder:
                            (context) => IconButton(
                              icon: const Icon(Icons.menu, color: Colors.white),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mobileWidth(context) * 0.15,
                        vertical: mobileHeight(context) * 0.07,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('QUIZ DUEL', style: headlineMediumStyle),
                            const SizedBox(height: 8),
                            Text('AI RIVAL', style: titleMediumStyle),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: (mobileHeight(context) * 0.5) - 280,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final double imageSize =
                                constraints.maxWidth * 0.70;
                            final double vsOffset = imageSize * 0.25;

                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      top: 4,
                                      left: 4,
                                      child: ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                          sigmaX: 8,
                                          sigmaY: 8,
                                        ),
                                        child: Image.asset(
                                          'assets/images/person_robot.png',
                                          width: imageSize,
                                          height: imageSize,
                                          fit: BoxFit.contain,
                                          color: greyBorderColor.withAlpha(
                                            (0.7 * 255).round(),
                                          ),
                                          colorBlendMode: BlendMode.srcATop,
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/images/person_robot.png',
                                      width: imageSize,
                                      height: imageSize,
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                ),
                                Positioned(
                                  bottom: vsOffset,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: circleWhiteShadowDecoration,
                                    child: Text(
                                      'VS',
                                      style: headlineMediumStyle.copyWith(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _CategoryTile(
                          title: "GK",
                          imagePath: "assets/images/General Knowledge.png",
                          interstitialAdController: interstitialAdController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _CategoryTile(
                          title: "Science",
                          imagePath: "assets/images/science.png",
                          interstitialAdController: interstitialAdController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _CategoryTile(
                          title: "History",
                          imagePath: "assets/images/history.png",
                          interstitialAdController: interstitialAdController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _CategoryTile(
                          title: "Word Power",
                          imagePath: "assets/images/wordpower.png",
                          interstitialAdController: interstitialAdController,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                interstitialAdController.handleTap(
                  onNavigate: () => Get.offAllNamed(AppRoutes.facts),
                );
              },
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final maxWidth = mobileWidth(context) * 0.9;
                    final height = mobileHeight(context) * 0.8;

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Main card
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: height * 0.13,
                            width: maxWidth,
                            padding: EdgeInsets.only(
                              left: height * 0.1 + 12,
                              right: 12,
                              top: 12,
                              bottom: 12,
                            ),
                            decoration: funFactsCardGradientDecoration,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fun Facts',
                                  style: titleSmallStyle.copyWith(
                                    fontSize: 20,
                                    color: kWhite,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Explore amazing facts across categories',
                                  style: questiontextStyle.copyWith(
                                    fontSize: 12,
                                    color: kWhite.withAlpha(
                                      (0.9 * 255).round(),
                                    ),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),

                        Positioned(
                          left: -20,
                          top: -height * 0.01,
                          child: SizedBox(
                            height: height * 0.18,
                            width: height * 0.18,
                            child: Lottie.asset(
                              'assets/images/factMedal.json',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            Obx(() {
              if (controller.isDrawerOpen.value) return const SizedBox.shrink();

              if (controller.adController.isAdLoaded.value) {
                return SizedBox(
                  height:
                      controller.adController.bannerAd.size.height.toDouble(),
                  width: controller.adController.bannerAd.size.width.toDouble(),
                  child: AdWidget(ad: controller.adController.bannerAd),
                );
              } else {
                return const ShimmerAdPlaceholder();
              }
            }),
          ],
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final String title;
  final String imagePath;
  final InterstitialAdController interstitialAdController;

  const _CategoryTile({
    required this.title,
    required this.imagePath,
    required this.interstitialAdController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        interstitialAdController.handleTap(
          onNavigate: () => Get.to(() => QuizQuestionPage(category: title)),
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final outerSize = width;

          return Container(
            height: outerSize * 0.8,
            width: outerSize * 0.8,
            decoration: roundedDecorationWithShadow,
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              top: 16,
              bottom: 8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: outerSize * 0.45,
                  width: outerSize * 0.45,
                  padding: const EdgeInsets.all(8),
                  decoration: skyTransparentBoxDecoration,
                  child: Image.asset(imagePath, fit: BoxFit.contain),
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Text(
                    title,
                    style: titleSmallStyle,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
