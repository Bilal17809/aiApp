import 'dart:ui';
import 'package:ai_app/core/constants/constants.dart';
import 'package:ai_app/presentations/pages.dart';
import 'package:lottie/lottie.dart';
import '../../../core/common_wgt/exitConfirmationDialog.dart';
import '../../../core/routes/app_routes.dart';
import '../../Ads/Banner/controller/banner_ad_controller.dart';
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
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              ClipPath(
                clipper: BottomCurveClipper(),
                child: Container(
                  height: isTablet(context) ? mobileHeight(context) * 0.48 : mobileHeight(context) * 0.45,

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
                      SizedBox(height: isTablet(context) ? 20 : 10),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: mobileWidth(context) * 0.15,
                          vertical: isTablet(context)
                              ? mobileHeight(context) * 0.09
                              : mobileHeight(context) * 0.07,

                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'QUIZ DUEL',
                                style: headlineMediumStyle.copyWith(
                                  fontSize: isTablet(context) ? 36 : 28,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'AI RIVAL',
                                style: titleMediumStyle.copyWith(
                                  fontSize: isTablet(context) ? 22 : 16,
                                ),
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: isTablet(context)
                            ? (mobileHeight(context) * 0.45) - 350
                            : (mobileHeight(context) * 0.47) - 280,

                        left: 0,
                        right: 0,
                        child: Center(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final double imageSize = isTablet(context)
                                  ? constraints.maxWidth * 0.45
                                  : constraints.maxWidth * 0.70;

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
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double spacing = isTablet(context) ? 20 : 15;
                    int crossAxisCount = isTablet(context) ? 3 : 2;

                    return Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: [
                        _CategoryTile(
                          title: "GK",
                          imagePath: "assets/images/General Knowledge.png",
                        ),
                        _CategoryTile(
                          title: "Science",
                          imagePath: "assets/images/science.png",
                        ),
                        _CategoryTile(
                          title: "History",
                          imagePath: "assets/images/history.png",
                        ),
                        _CategoryTile(
                          title: "Word Power",
                          imagePath: "assets/images/wordpower.png",
                        ),
                      ].map((tile) {
                        return SizedBox(
                          width: (constraints.maxWidth - spacing * (crossAxisCount - 1)) / crossAxisCount,
                          child: tile,
                        );
                      }).toList(),
                    );
                  },
                ),
              ),

              GestureDetector(
                onTap: () {
                  Get.offAllNamed(AppRoutes.facts);
                },
                child: Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final screenWidth = MediaQuery.of(context).size.width;
                      final screenHeight = MediaQuery.of(context).size.height;
                      final maxWidth = isTablet(context) ? screenWidth * 0.6 : screenWidth * 0.9;
                      final cardHeight = isTablet(context) ? screenHeight * 0.11 : screenHeight * 0.11;
                      final iconSize = isTablet(context) ? screenHeight * 0.11 : screenHeight * 0.16;

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
                              height: cardHeight,
                              width: maxWidth,
                              padding: EdgeInsets.only(
                                left: cardHeight * 0.8 + 12,
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
                            top: -cardHeight * 0.1,
                            child: SizedBox(
                              height: iconSize,
                              width: iconSize,
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
            ],
          ),
        ),
        bottomNavigationBar: Obx(() {
          final banner = Get.find<BannerAdController>();
           if(controller.isDrawerOpen.value){
             return SizedBox();
           }
          return banner.getBannerAdWidget('ad1');
        }),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final String title;
  final String imagePath;

  const _CategoryTile({
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
         Get.to(() => QuizQuestionPage(category: title));
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final outerSize = width;

          return Container(
            height: outerSize * 0.78,
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
                  height: outerSize * 0.42,
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

const EdgeInsets verticalButtonPadding = EdgeInsets.symmetric(vertical: 16);
bool isTablet(BuildContext context) {
  return MediaQuery.of(context).size.shortestSide >= 600;
}