import 'dart:ui';
import 'package:ai_app/presentations/pages.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../Banner/interstitial_ad_controller.dart';
import '../../Drawer/view/customdrawer.dart';
import '../../home/controller/home_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common_wgt/bottom_curve_clipper.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../quiz/view/quiz_screen.dart';
import 'package:ai_app/core/utils/network_utils.dart';
import '../../../Banner/banner_ad_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final BannerAdController adController = Get.put(BannerAdController());
    final interstitialAdController = Get.put(InterstitialAdController());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      NetworkUtils.checkInternet(context);

      await Future.delayed(const Duration(seconds: 1));

      final interstitialAdController = Get.find<InterstitialAdController>();
      if (interstitialAdController.isAdLoaded.value) {
        interstitialAdController.showAd();
      }
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   NetworkUtils.checkInternet(context);
    // });
    return Scaffold(
      drawer: const CustomDrawer(),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                color: skyColor,
                child: Stack(
                  children: [
                    Positioned(
                      left: 8,
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
                        horizontal: MediaQuery.of(context).size.width * 0.12,
                        vertical: MediaQuery.of(context).size.height * 0.04,
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
                      top: (MediaQuery.of(context).size.height * 0.5) - 300,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final double imageSize =
                                constraints.maxWidth * 0.90;
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
                                          color: greyBorderColor.withOpacity(
                                            0.7,
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
                                    padding: const EdgeInsets.all(10),
                                    decoration: circleWhiteShadowDecoration,
                                    child: Text(
                                      'VS',
                                      style: headlineMediumStyle,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: [
                    _CategoryTile(
                      title: "General Knowledge",
                      imagePath: "assets/images/book.png",
                      interstitialAdController: interstitialAdController,
                    ),
                    _CategoryTile(
                      title: "Science",
                      imagePath: "assets/images/search.png",
                      interstitialAdController: interstitialAdController,
                    ),
                    _CategoryTile(
                      title: "History",
                      imagePath: "assets/images/employment-records.png",
                      interstitialAdController: interstitialAdController,
                    ),
                    _CategoryTile(
                      title: "Word Power",
                      imagePath: "assets/images/spell-check.png",
                      interstitialAdController: interstitialAdController,
                    ),
                  ],
                ),
              ),
            ),

            /// BANNER AD AREA
            Obx(() {
              if (adController.isAdLoaded.value) {
                return SizedBox(
                  height: adController.bannerAd.size.height.toDouble(),
                  width: adController.bannerAd.size.width.toDouble(),
                  child: AdWidget(ad: adController.bannerAd),
                );
              } else {
                return const SizedBox.shrink();
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
        if (interstitialAdController.isAdLoaded.value) {
          interstitialAdController.showAd();
        }
        Get.to(() => QuizQuestionPage(category: title));
      },
      child: Container(
        decoration: roundedDecorationWithShadow,
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 70,
              padding: const EdgeInsets.all(8),
              decoration: skyTransparentBoxDecoration,
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              style: titleSmallStyle,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
