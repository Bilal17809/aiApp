import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/quiz_controller.dart';

class QuizQuestionPage extends StatelessWidget {
  final String category;
  const QuizQuestionPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizController>();

    return Obx(() {
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

      final question = controller.questions[controller.currentQuestionIndex.value];

      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xFF02A6A5),
                      Color(0xFF65DF94),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Left circular decoration
                    Positioned(
                      top: 0,
                      left: -50,
                      child: Opacity(
                        opacity: 0.3,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF65DF94),
                                Color(0xFF00ADA3),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha((0.2 * 255).round()),
                                blurRadius: 12,
                                spreadRadius: 4,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Right circular decoration
                    Positioned(
                      top: 0,
                      right: -50,
                      child: Opacity(
                        opacity: 0.3,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF65DF94),
                                Color(0xFF00ADA3),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha((0.2 * 255).round()),
                                blurRadius: 12,
                                spreadRadius: 4,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Main Content
                    Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            Text(category, style: headlineSmallStyle),
                            const Spacer(),
                            Text(
                              "${controller.currentQuestionIndex.value + 1}/${controller.questions.length}",
                              style: headlineSmallStyle,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          value: (controller.currentQuestionIndex.value + 1) / controller.questions.length,
                          backgroundColor: kBlue,
                          color: kWhite,
                          minHeight: 6,
                        ),
                      ],
                    ),
                  ],
                ),
              )


              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       begin: Alignment.bottomCenter,
              //       end: Alignment.topCenter,
              //       colors: [
              //
              //         Color(0xFF02A6A5),
              //         Color(0xFF65DF94),
              //
              //     ]
              //     ),
              //   ),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //
              //           const SizedBox(width: 10),
              //           Text(category, style: headlineSmallStyle),
              //           const Spacer(),
              //           Text(
              //             "${controller.currentQuestionIndex.value + 1}/${controller.questions.length}",
              //             style: headlineSmallStyle,
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 10),
              //       LinearProgressIndicator(
              //         value: (controller.currentQuestionIndex.value + 1) / controller.questions.length,
              //         backgroundColor: kBlue,
              //         color: kWhite,
              //         minHeight: 6,
              //       ),
              //     ],
              //   ),
              // ),


              ,Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                      child: Obx(() => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: roundedDecoration,
                        child: Text(
                          controller.aiMessage.value,
                          style: bodyMediumStyle,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2, // optional: limit to 2 lines
                        ),
                      )),
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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(question.question, style: titleLargeStyle),
                      const SizedBox(height: 30),


                      ...List.generate(question.options.length, (index) {
                        final isSelected = controller.selectedIndex.value == index;
                        final isCorrect = index == question.answerIndex;
                        final hasAnswered = controller.selectedIndex.value != -1;

                        Color bgColor = kWhite;
                        Widget? trailingIcon;

                        if (hasAnswered) {
                          if (isSelected && isCorrect) {
                            bgColor = kLightGreen1;
                            trailingIcon = const Icon(Icons.check, color: Colors.green);
                          } else if (isSelected && !isCorrect) {
                            bgColor = kLightRed;
                            trailingIcon = const Icon(Icons.close, color: Colors.red);
                          }
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: !hasAnswered
                                  ? () => controller.selectAnswer(index)
                                  : null,
                              child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 14),
                                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                                decoration: roundedgreyBorderDecoration.copyWith(color: bgColor),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(child: Text(question.options[index], style: titleSmallStyle)),
                                    if (trailingIcon != null) trailingIcon,
                                  ],
                                ),
                              ),
                            ),

                            if (isSelected && hasAnswered)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8, left: 12),
                                child: Text(
                                  isCorrect ? "Correct ✅" : "Wrong ❌",
                                  style: TextStyle(
                                    color: isCorrect ? Colors.green : Colors.red,
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

            ]
          ),
        ),
      );
    });
  }
}
