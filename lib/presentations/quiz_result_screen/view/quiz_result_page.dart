import 'package:ai_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common_wgt/elevated_button.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_styles.dart';
import 'package:lottie/lottie.dart';
import '../../quiz_screen/controller/quiz_controller.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizController>();
    final double percentage =
        ((controller.userScore.value / (controller.questions.length)) * 100)
            .roundToDouble();

    final bool isWinner = percentage > 50;
    final String resultImage =
        isWinner
            ? 'assets/images/Winner.json'
            : 'assets/images/Error_Occurred!.json';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32,
              ),
              child: Column(
                children: [
                  Text('🎉 Quiz Completed!', style: titleLargeStyle),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _ScoreCard(
                        title: 'You',
                        image: 'assets/images/man-avatar_home_Screen.png',
                        score: controller.userScore.value,
                      ),
                      const Text('VS', style: titleLargeStyle),
                      _ScoreCard(
                        title: 'AI',
                        image: 'assets/images/robot-assistant.png',
                        score: controller.aiScore.value,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  SizedBox(
                    height: isWinner ? screenHeight * 0.4 : screenHeight * 0.3,
                    child: Lottie.asset(resultImage, fit: BoxFit.contain),
                  ),
                  const Spacer(),
                  Text(
                    "Percentage: ${percentage.toInt()}%",
                    style: titleMediumStyle.copyWith(color: blackTextColor),
                  ),
                  const SizedBox(height: 20),
                  CommonFilledButton(
                    text: isWinner ? 'Play Again' : 'Try Again',
                    onPressed: () {
                      controller.resetQuiz();
                      Get.offAllNamed(AppRoutes.home);
                    },
                    backgroundColor: skyColor,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final String title;
  final String image;
  final int score;

  const _ScoreCard({
    required this.title,
    required this.image,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(backgroundImage: AssetImage(image), radius: 40),
        const SizedBox(height: 10),
        Text(title, style: headlineSmallStyle.copyWith(color: blackTextColor)),
        const SizedBox(height: 6),
        Text(
          'Score: $score',
          style: titleMediumStyle.copyWith(color: blackTextColor),
        ),
      ],
    );
  }
}
