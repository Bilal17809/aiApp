import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common_wgt/dialog_helpers.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/audio_player.dart';
import '../../Ads/Interstitial/controller/interstitial_ad_controller.dart';
import '../../quiz_result_screen/view/quiz_result_page.dart';
import '../controller/quiz_controller.dart';
import '../widget/QuestionAndOptionsSection.dart';

class QuizQuestionPage extends StatelessWidget {
  final String category;

  final QuizController controller = Get.put(QuizController());

  QuizQuestionPage({super.key, required this.category}) {
    controller.resetQuiz();
    controller.loadQuestions(category);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, value) {
        if (!didPop) {
          Get.offAllNamed(AppRoutes.home);
          SoundPlayer.stop();
        }
      },
      child: Obx(() {
        if (controller.isLoading.value) {
          Future.delayed(const Duration(seconds: 5), () {
            if (controller.isLoading.value) {
              showNetworkDialog(
                context: context,
                title: 'Network Issue',
                message: 'Your internet is too slow. Please try again.',
                onRetry: () {
                  Navigator.of(context).pop();
                  controller.loadQuestions(category);
                },
              );
            }
          });

          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (controller.questions.isEmpty) {
          Future.microtask(() {
            showNetworkDialog(
              context: context,
              onRetry: () {
                Navigator.of(context).pop();
                controller.loadQuestions(category);
              },
            );
          });

          return const Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox.shrink(),
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 30,
                  ),
                  color: skyColor,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Text(category, style: headlineSmallStyle),
                          const Spacer(),
                          Text(
                            "${controller.currentQuestionIndex.value + 1}/10",
                            style: headlineSmallStyle,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: (controller.currentQuestionIndex.value + 1) / 10,
                        backgroundColor: kBlue,
                        color: kWhite,
                        minHeight: 6,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: circleAvatarDecoration,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/man-avatar_home_Screen.png',
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${controller.userScore}',
                            style: bodyMediumStyle,
                          ),
                        ],
                      ),
                      Flexible(
                        child: Obx(() {
                          final msg = controller.aiMessage.value.trim();
                          if (msg.isEmpty) return const SizedBox.shrink();

                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: roundedDecoration,
                            child: Text(
                              msg,
                              style: bodyMediumStyle,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          );
                        }),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: circleAvatarDecoration,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/robot-assistant.png',
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text('${controller.aiScore}', style: bodyMediumStyle),
                        ],
                      ),
                    ],
                  ),
                ),

                QuestionAndOptionsSection(controller: controller),
                Obx(() {
                  if (controller.shouldNavigateToResult.value) {
                    controller.shouldNavigateToResult.value = false;
                    Get.find<InterstitialAdController>().forceShowAdAfterQuiz(
                      onComplete: () => Get.off(() => const QuizResultPage()),
                    );
                  }
                  return const SizedBox.shrink();
                }),
          ],
            ),
          ),
        );
      }),
    );
  }
}
