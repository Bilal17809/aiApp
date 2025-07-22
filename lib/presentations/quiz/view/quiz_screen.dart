import 'package:ai_app/presentations/quiz/view/quiz_result_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/audio_player.dart';
import '../../Ads/Interstitial/controller/interstitial_ad_controller.dart';
import '../controller/quiz_controller.dart';
/*
this file code is not accepted.
 define all color in theme, just use here/
 why we need this  WidgetsBinding.instance.addPostFrameCallback????/

 for good hierarchy make private stateless class below/
  expended-Single will be in separate stateless class

*/
class QuizQuestionPage extends StatelessWidget {
  final String category;
  final adController = Get.find<InterstitialAdController>();

  QuizQuestionPage({super.key, required this.category}) {
    final controller = Get.find<QuizController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.resetQuiz();
      adController.showAdOnce();

      controller.loadQuestions(category);

      ever(controller.isQuizCompleted, (completed) {
        if (completed == true) {
          Future.delayed(const Duration(milliseconds: 200), () {
            adController.resetAdFlag();

            adController.showAdOnce();

            Get.off(() => const QuizResultPage());
          });
        }
      });
    });
  }

  final controller = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.delete<QuizController>(tag: category);
        controller.resetQuiz();
        SoundPlayer.stop();

        return true;
      },
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (controller.questions.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("No questions available")),
          );
        }

        final question =
            controller.questions[controller.currentQuestionIndex.value];

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
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.question,
                          style: questiontextStyle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 30),
                        ...List.generate(question.options.length, (index) {
                          final hasAnswered =
                              controller.selectedIndex.value != -1;
                          final isCorrect = index == question.answerIndex;
                          final isUserSelected =
                              controller.userSelectedIndex.value == index;
                          final isAiCorrected =
                              controller.aiCorrectedIndex.value == index;

                          Color bgColor = getOptionColor(index);
                          Widget? trailingIcon;

                          if (hasAnswered) {
                            if (isAiCorrected &&
                                index == controller.aiCorrectedIndex.value) {
                              trailingIcon = const Icon(
                                Icons.check,
                                color: kMediumGreen2,
                              );
                            } else if (isUserSelected &&
                                index == controller.userSelectedIndex.value &&
                                controller.userSelectedIndex.value !=
                                    controller.aiCorrectedIndex.value) {
                              trailingIcon = const Icon(
                                Icons.close,
                                color: kRed,
                              );
                            } else if (index ==
                                    controller.selectedIndex.value &&
                                index == question.answerIndex) {
                              trailingIcon = const Icon(
                                Icons.check,
                                color: kMediumGreen2,
                              );
                            } else if (index ==
                                    controller.selectedIndex.value &&
                                index != question.answerIndex) {
                              trailingIcon = const Icon(
                                Icons.close,
                                color: kRed,
                              );
                            }
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap:
                                    !hasAnswered
                                        ? () => controller.selectAnswer(index)
                                        : null,
                                child: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 14),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 20,
                                  ),
                                  decoration: roundedgreyBorderDecoration
                                      .copyWith(color: bgColor),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          question.options[index],
                                          style: titleSmallStyle,
                                        ),
                                      ),
                                      if (trailingIcon != null) trailingIcon,
                                    ],
                                  ),
                                ),
                              ),
                              if (hasAnswered &&
                                  ((isUserSelected &&
                                          controller.userSelectedIndex.value !=
                                              controller
                                                  .aiCorrectedIndex
                                                  .value &&
                                          index ==
                                              controller
                                                  .userSelectedIndex
                                                  .value) ||
                                      (isAiCorrected &&
                                          index ==
                                              controller
                                                  .aiCorrectedIndex
                                                  .value) ||
                                      (index ==
                                          controller.selectedIndex.value)))
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8,
                                    left: 12,
                                  ),
                                  child: Text(
                                    (isCorrect || isAiCorrected)
                                        ? "Correct ✅"
                                        : "Wrong ❌",
                                    style: TextStyle(
                                      color:
                                          (isCorrect || isAiCorrected)
                                              ? kMediumGreen2
                                              : kRed,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }),


                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }


  Color getOptionColor(int index) {
    final quiz = Get.find<QuizController>();
    final question = quiz.questions[quiz.currentQuestionIndex.value];

    final selected = quiz.selectedIndex.value;
    final userSelected = quiz.userSelectedIndex.value;
    final aiCorrected = quiz.aiCorrectedIndex.value;


    if (aiCorrected != -1) {
      if (index == aiCorrected) return kMediumGreen2.withAlpha(50);
      if (index == userSelected && userSelected != aiCorrected)
        return kRed.withAlpha(50);
    }

    if (selected != -1) {
      if (index == selected && index == question.answerIndex)
        return kMediumGreen2.withAlpha(50);
      if (index == selected && index != question.answerIndex)
        return kRed.withAlpha(50);
    }

    return kWhite;
  }
}
