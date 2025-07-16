import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../presentations/quiz/controller/quiz_controller.dart';
import '../../../presentations/quiz/view/quiz_screen.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';
class CategoryTile extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color? color;

  const CategoryTile({
    super.key,
    required this.title,
    required this.imagePath,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        final controller = Get.put(QuizController());

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
                gradient: const LinearGradient(
                  colors: [
                    Color(0x26E8F5E9), // 15% opacity
                    Color(0x261B5E20), // 15% opacity
                    // Color(0x1AE8F5E9), //  @ 10%
                    // Color(0x1A1B5E20),//  @ 10%
                    // Color(0x33E8F5E9), // 20% opacity
                    // Color(0x331B5E20), // 20% opacity
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),


                borderRadius: BorderRadius.circular(12),

              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
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
