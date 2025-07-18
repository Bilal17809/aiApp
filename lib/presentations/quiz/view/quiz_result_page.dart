import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../controller/quiz_controller.dart';
import 'package:lottie/lottie.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizController>();
    final int userScore = controller.userScore.value;
    final int aiScore = controller.aiScore.value;
    final int totalQuestions = controller.questions.length;
    final int userPercentage =
    ((userScore / (totalQuestions * 10)) * 100).round();

    final String resultImage = userPercentage > 50
        ? 'assets/images/Winner.json'
        : 'assets/images/Error_Occurred!.json';

    final double screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight =  userPercentage > 50?screenHeight * 0.4:screenHeight*0.3;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '🎉 Quiz Completed!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _scoreCard(
                      title: 'You',
                      image: 'assets/images/man-avatar_home_Screen.png',
                      score: userScore,
                    ),
                    const Text(
                      'VS',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    _scoreCard(
                      title: 'AI',
                      image: 'assets/images/robot-assistant.png',
                      score: aiScore,
                    ),
                  ],
                ),
                const SizedBox(height: 30),


                Lottie.asset(
                  resultImage,
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
          
                const SizedBox(height: 30),
                Text("Percentage: $userPercentage%", style: titleMediumStyle),
                const SizedBox(height: 40),
          
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.resetQuiz();
                      Get.offAllNamed(AppRoutes.home);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: skyColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      userPercentage > 50 ? 'Play Again' : 'Try Again',
                      style: bodyLargeStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _scoreCard({
    required String title,
    required String image,
    required int score,
  }) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(image),
          radius: 40,
        ),
        const SizedBox(height: 10),
        Text(title, style: headlineSmallStyle),
        const SizedBox(height: 6),
        Text('Score: $score', style: titleMediumStyle),
      ],
    );
  }
}
