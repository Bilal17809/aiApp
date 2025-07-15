import 'package:ai_app/core/theme/app_colors.dart';
import 'package:ai_app/core/theme/app_styles.dart';
import 'package:ai_app/presentations/pages.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../quiz/controller/quiz_controller.dart';
import '../../quiz/view/quiz_screen.dart';


class HomePage extends GetView<HomeController> {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          ClipPath(
            clipper: BottomCurveClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [skyColor, skyColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'QUIZ DUEL',
                    style: headlineMediumStyle,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'AI RIVAL',
                    style: headlineSmallStyle,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/man-avatar_home_Screen.png',
                        height: 120,
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: circleWhiteBorderDecoration,
                        child: const Text(
                          'VS',
                          style: headlineSmallStyle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Image.asset(
                        'assets/images/robot-assistant.png',
                        height: 120,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),


          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildQuizButton("General Knowledge", onTap: () async {



                    Get.dialog(
                      const Center(child: CircularProgressIndicator()),
                      barrierDismissible: false,
                    );

                    final controller = Get.put(QuizController());

                    try {
                      await controller.loadQuestions("General Knowledge");
                      Get.back();
                      Get.to(() => const QuizQuestionPage(category: "General Knowledge"));
                    } catch (e) {
                      Get.back();
                      Get.snackbar("Error", e.toString());
                    }
                  }),






                  buildQuizButton("Science", onTap: () async {

                    Get.dialog(
                      const Center(child: CircularProgressIndicator()),
                      barrierDismissible: false,
                    );

                    final controller = Get.put(QuizController());

                    try {
                      await controller.loadQuestions("Science");
                      Get.back();
                      Get.to(() => const QuizQuestionPage(category: "Science"));
                    } catch (e) {
                      Get.back();
                      Get.snackbar("Error", e.toString());
                    }
                  }),
                  buildQuizButton("History", onTap: () async {

                    Get.dialog(
                      const Center(child: CircularProgressIndicator()),
                      barrierDismissible: false,
                    );

                    final controller = Get.put(QuizController());

                    try {
                      await controller.loadQuestions("History");
                      Get.back();
                      Get.to(() => const QuizQuestionPage(category: "History"));
                    } catch (e) {
                      Get.back();
                      Get.snackbar("Error", e.toString());
                    }
                  }),
                  buildQuizButton("Word Power", onTap: () async {

                    Get.dialog(
                      const Center(child: CircularProgressIndicator()),
                      barrierDismissible: false,
                    );

                    final controller = Get.put(QuizController());

                    try {
                      await controller.loadQuestions("Word Power");
                      Get.back();
                      Get.to(() => const QuizQuestionPage(category: "Word Power"));
                    } catch (e) {
                      Get.back();
                      Get.snackbar("Error", e.toString());
                    }
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildQuizButton(String label, {required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
        child: Text(
          label,
          style: buttonTextStyle,
        ),
      ),
    );
  }
}


class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2, size.height,
      size.width, size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
