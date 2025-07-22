import 'dart:ui';
import 'package:ai_app/presentations/pages.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import '../../../core/routes/app_routes.dart';
import '../../Ads/Banner/controller/banner_ad_controller.dart';
import '../../Ads/Interstitial/controller/interstitial_ad_controller.dart';
import '../../Drawer/view/customdrawer.dart';
import '../../home/controller/home_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common_wgt/bottom_curve_clipper.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../quiz/view/quiz_screen.dart';
import 'package:ai_app/core/utils/network_utils.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final BannerAdController adController = Get.put(BannerAdController());
    final interstitialAdController = Get.put(InterstitialAdController());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      NetworkUtils.checkInternet(context);

      await Future.delayed(const Duration(seconds: 1));

      if (interstitialAdController.isAdLoaded.value) {
        interstitialAdController.showAdOnce();
      }
    });

    return Scaffold(
      drawer: const CustomDrawer(),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          ClipPath(
            clipper: BottomCurveClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              color: skyColor,
              child: Stack(
                children: [
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.01,
                    top: MediaQuery.of(context).size.height * 0.06,
                    child: Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.15,
                      vertical: MediaQuery.of(context).size.height * 0.07,
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
                    top: (MediaQuery.of(context).size.height * 0.5) - 280,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final double imageSize = constraints.maxWidth * 0.70;
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
                                        color:
                                        greyBorderColor.withOpacity(0.7),
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
                                    style: headlineMediumStyle.copyWith(fontSize: 25),
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
                        title: "General Knowledge",
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
              Get.offAllNamed(AppRoutes.facts);
            },
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = MediaQuery.of(context).size.width * 0.9;
                  final height = MediaQuery.of(context).size.height * 0.8;

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
                                  color: kWhite.withOpacity(0.9),
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
          interstitialAdController.resetAdFlag();
          interstitialAdController.showAdOnce();
        }
        Get.to(() => QuizQuestionPage(category: title));
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final outerSize = width;

          return Container(
            height: outerSize * 0.8,
            width: outerSize * 0.8,
            decoration: roundedDecorationWithShadow,
            padding:const EdgeInsets.only(
              left: 8,
              right: 8,
              top: 16,
              bottom: 8

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: outerSize * 0.45,
                  width: outerSize * 0.45,
                  padding: const EdgeInsets.all(8),
                  decoration: skyTransparentBoxDecoration,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
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


