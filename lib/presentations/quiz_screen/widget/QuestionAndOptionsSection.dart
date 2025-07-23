import 'package:flutter/material.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/quiz_controller.dart';

class QuestionAndOptionsSection extends StatelessWidget {
  final QuizController controller;

  const QuestionAndOptionsSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    final question =
        controller.questions[controller.currentQuestionIndex.value];

    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
              final hasAnswered = controller.selectedIndex.value != -1;
              final isCorrect = index == question.answerIndex;
              final isUserSelected =
                  controller.userSelectedIndex.value == index;
              final isAiCorrected = controller.aiCorrectedIndex.value == index;

              Color bgColor = getOptionColor(index, controller);
              Widget? trailingIcon;

              if (hasAnswered) {
                if (isUserSelected && index == question.answerIndex) {
                  trailingIcon = const Icon(Icons.check, color: kMediumGreen2);
                } else if (isAiCorrected) {
                  trailingIcon = const Icon(Icons.check, color: kMediumGreen2);
                } else if (isUserSelected) {
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
                      decoration: roundedgreyBorderDecoration.copyWith(
                        color: bgColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  controller.aiCorrectedIndex.value &&
                              index == controller.userSelectedIndex.value) ||
                          (isAiCorrected &&
                              index == controller.aiCorrectedIndex.value) ||
                          (index == controller.selectedIndex.value)))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, left: 12),
                      child: Text(
                        (isCorrect || isAiCorrected) ? "Correct ✅" : "Wrong ❌",
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
    );
  }

  Color getOptionColor(int index, QuizController quiz) {
    final question = quiz.questions[quiz.currentQuestionIndex.value];
    final selected = quiz.selectedIndex.value;
    final userSelected = quiz.userSelectedIndex.value;
    final aiCorrected = quiz.aiCorrectedIndex.value;

    if (aiCorrected != -1) {
      if (index == aiCorrected) return kMediumGreen2.withAlpha(50);
      if (index == userSelected && userSelected != aiCorrected) {
        return kRed.withAlpha(50);
      }
    }

    if (selected != -1) {
      if (index == selected && index == question.answerIndex) {
        return kMediumGreen2.withAlpha(50);
      }
      if (index == selected && index != question.answerIndex) {
        return kRed.withAlpha(50);
      }
    }

    return kWhite;
  }
}
