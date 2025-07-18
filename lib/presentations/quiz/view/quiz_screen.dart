import 'package:ai_app/presentations/quiz/view/quiz_result_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/audio_player.dart';
import '../controller/quiz_controller.dart';

class QuizQuestionPage extends StatefulWidget {
  final String category;
  const QuizQuestionPage({super.key, required this.category});

  @override
  State<QuizQuestionPage> createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> {
  final controller = Get.find<QuizController>();
  @override
  void initState() {
    super.initState();
    controller.loadQuestions(widget.category);

    ever(controller.isQuizCompleted, (completed) {
      if (completed == true) {
        Future.delayed(const Duration(milliseconds: 200), () {
          Get.off(() => const QuizResultPage());
        });
      }
    });
  }

  @override
  void dispose() {
    SoundPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
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
                        Text(widget.category, style: headlineSmallStyle),
                        const Spacer(),
                        Text(
                          "${controller.currentQuestionIndex.value + 1}/${10}",
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
                        Text('${controller.userScore}', style: bodyMediumStyle),
                      ],
                    ),
                    Flexible(
                      child: Obx(() {
                        final msg = controller.aiMessage.value.trim();
                        if (msg.isEmpty) {
                          return const SizedBox.shrink();
                        }

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
                        final isSelected =
                            controller.selectedIndex.value == index;
                        final isCorrect = index == question.answerIndex;
                        final hasAnswered =
                            controller.selectedIndex.value != -1;

                        Color bgColor = kWhite;
                        Widget? trailingIcon;

                        if (hasAnswered) {
                          if (isSelected && isCorrect) {
                            bgColor = kLightGreen1;
                            trailingIcon = const Icon(
                              Icons.check,
                              color: kMediumGreen2,
                            );
                          } else if (isSelected && !isCorrect) {
                            bgColor = kLightRed;
                            trailingIcon = const Icon(Icons.close, color: kRed);
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

                            if (isSelected && hasAnswered)
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                  left: 12,
                                ),
                                child: Text(
                                  isCorrect ? "Correct ✅" : "Wrong ❌",
                                  style: TextStyle(
                                    color: isCorrect ? kMediumGreen2 : kRed,
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
    });
  }
}
