import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_app/core/theme/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_theme.dart';
import '../controller/fact_controller.dart';

> define this in content file just call and use here
height: MediaQuery.of(context).size.height

inside the constant check there is already body height define, use it
*/
class FactPage extends StatelessWidget {
  const FactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FactController>();
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoutes.home);
        return false;
      },
      child: Scaffold(

        backgroundColor: bgColor,
        body: Obx(() {
          if (controller.facts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: kWhite),
            );
          }

          final currentFact = controller.facts[controller.currentPage.value];

          return Stack(
            children: [
              Positioned(
                top: -size.width * 0.4,
                left: -size.width * 0.2,
                child: Container(
                  width: size.width * 1.5,
                  height: size.width * 1.5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: skyColor,
                  ),
                ),
              ),

              // Main Content
              Column(
                children: [
                  const SizedBox(height: 80),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        currentFact.category,
                        style: headlineSmallStyle.copyWith(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),


                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: controller.onPageChanged,
                      itemCount: controller.facts.length,
                      itemBuilder: (context, index) {
                        final fact = controller.facts[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Container(
                                margin: const EdgeInsets.only(
                                  top: 50,
                                  bottom: 30,
                                ),
                                padding: const EdgeInsets.all(24),
                                decoration: roundedDecorationWithShadow
                                    .copyWith(color: Colors.white),
                                constraints: BoxConstraints(
                                  minHeight: size.height * 0.1,
                                  maxHeight: size.height * 0.32,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Text(
                                          fact.fact,
                                          textAlign: TextAlign.center,
                                          style: questiontextStyle.copyWith(
                                            fontSize: 18,
                                            color: blackTextColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Obx(() {
                                      final total = controller.facts.length;
                                      final current =
                                          controller.currentPage.value + 1;

                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            onPressed:
                                                controller.currentPage.value > 0
                                                    ? controller
                                                        .goToPreviousPage
                                                    : null,
                                            icon: const Icon(
                                              Icons.arrow_back_ios_new,
                                            ),
                                            color:
                                                controller.currentPage.value > 0
                                                    ? kBlack
                                                    : Colors.grey,
                                            iconSize: 24,
                                          ),

                                          Text(
                                            '$current / $total',
                                            style: questiontextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: kBlack,
                                            ),
                                          ),

                                          IconButton(
                                            onPressed:
                                                controller.currentPage.value <
                                                        total - 1
                                                    ? controller.goToNextPage
                                                    : null,
                                            icon: const Icon(
                                              Icons.arrow_forward_ios,
                                            ),
                                            color:
                                                controller.currentPage.value <
                                                        total - 1
                                                    ? kBlack
                                                    : Colors.grey,
                                            iconSize: 24,
                                          ),
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                              );
                            },
                          ),
                        );


                      },
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                  Obx(() {
                    final totalDots = min(6, controller.facts.length);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(totalDots, (dotIndex) {
                        final realIndex =
                            controller.currentPage.value % totalDots;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: realIndex == dotIndex ? 20 : 8,
                          decoration: BoxDecoration(
                            color: realIndex == dotIndex ? skyColor : greyColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        );
                      }),
                    );
                  }),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),




                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
