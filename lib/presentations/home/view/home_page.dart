import 'dart:ui';
import 'package:ai_app/presentations/pages.dart';
import '../../home/controller/home_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common_wgt/bottom_curve_clipper.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../quiz/controller/quiz_controller.dart';
import '../../quiz/view/quiz_screen.dart';
import 'package:ai_app/core/utils/network_utils.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NetworkUtils.checkInternet(context);
    });
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(color: skyColor),
                child: Stack(
                  children: [
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
                            Text(
                              'QUIZ DUEL',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'AI RIVAL',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                                fontFamily: 'Poppins',
                              ),
                            ),
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
                                          color: Colors.grey.withOpacity(0.9),
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
                                    decoration: BoxDecoration(
                                      color: skyColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 12,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      'VS',
                                      style: TextStyle(
                                        fontSize: imageSize * 0.08,
                                        fontWeight: FontWeight.bold,
                                        color: kWhite,
                                        fontFamily: 'Poppins',
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
                      imagePath: "assets/images/general.png",
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
                      imagePath: "assets/images/word_power.png",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color? color;

  const _CategoryTile({
    super.key,
    required this.title,
    required this.imagePath,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final controller = Get.put(QuizController());
        if (controller.isLoading.value) return;

        try {
          await controller.loadQuestions(title);
          Get.back();
          Get.to(() => QuizQuestionPage(category: title));
        } catch (e) {
          Get.back();
          Get.snackbar("Error", e.toString());
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(38),

              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 70,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: skyColor.withAlpha(60),

                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              style: titleSmallStyle.copyWith(
                color: kBlack,
                fontWeight: FontWeight.bold,
              ),
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
