import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_app/core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../controller/fact_controller.dart';

class FactPage extends StatelessWidget {
  const FactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FactController>();

    return Scaffold(
      backgroundColor: skyColor,
      appBar: AppBar(
        backgroundColor: skyColor,
        title: const Text(
          'Fun Facts',
          style: titleMediumStyle,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kWhite,),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.facts.isEmpty) {
          return const Center(
              child: CircularProgressIndicator(color: kWhite));
        }

        return PageView.builder(
          itemCount: controller.facts.length,
          onPageChanged: controller.onPageChanged,
          itemBuilder: (context, index) {
            final fact = controller.facts[index];

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Container(
                    decoration: roundedDecorationWithShadow,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            fact.category,
                            style: titleSmallStyle.copyWith(
                              color: kIndigo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            fact.fact,
                            textAlign: TextAlign.center,
                            style: questiontextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: blackTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
