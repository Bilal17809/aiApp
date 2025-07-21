import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../home/view/home_page.dart';
import '../controller/splash_controller.dart';
import '../../../core/theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset('assets/images/splash.png', fit: BoxFit.cover),
          ),

          Column(
            children: [
              const Spacer(flex: 5),

              SizedBox(
                height: size.height * 0.50,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 25,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            'YOU',
                            textStyle: GoogleFonts.bebasNeue(
                              fontSize: size.width * 0.3,
                              color: textWhiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                        isRepeatingAnimation: false,
                        totalRepeatCount: 1,
                      ),
                    ),

                    Obx(
                      () =>
                          controller.vsVisible.value
                              ? Positioned(
                                top: size.height * 0.19,
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      'VS',
                                      textStyle: TextStyle(
                                        fontSize: size.width * 0.08,
                                        fontWeight: FontWeight.bold,
                                        color: textWhiteColor,
                                      ),
                                      speed: const Duration(milliseconds: 80),
                                    ),
                                  ],
                                  isRepeatingAnimation: false,
                                  totalRepeatCount: 1,
                                ),
                              )
                              : const SizedBox(),
                    ),

                    Obx(
                      () =>
                          controller.aiVisible.value
                              ? Positioned(
                                top: size.height * 0.18,
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      'Ai',
                                      textStyle: GoogleFonts.orbitron(
                                        fontSize: size.width * 0.3,
                                        color: textWhiteColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      speed: const Duration(milliseconds: 100),
                                    ),
                                  ],
                                  isRepeatingAnimation: false,
                                  totalRepeatCount: 1,
                                ),
                              )
                              : const SizedBox(),
                    ),
                  ],
                ),
              ),

              Obx(() {
                return controller.showButton.value
                    ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.2,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: yellowButtonColor,
                            padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Get.off(() => const HomePage());
                          },
                          child: Text(
                            'Let\'s Go',
                            style: TextStyle(
                              color: blackTextColor,
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                    : Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: textWhiteColor,
                        size: size.width * 0.12,
                      ),
                    );
              }),

              SizedBox(height: size.height * 0.05),
            ],
          ),
        ],
      ),
    );
  }
}
