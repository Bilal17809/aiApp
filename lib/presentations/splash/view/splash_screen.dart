import 'package:ai_app/core/theme/app_theme.dart';
import 'package:ai_app/presentations/Ads/Banner/controller/banner_ad_controller.dart';
import 'package:ai_app/presentations/Ads/splash_interstitial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_styles.dart';
import '../controller/splash_controller.dart';
import '../../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController controller = Get.put(SplashController());
  final SplashAds=Get.find<SplashInterstitialAdController>();
@override
  void initState() {
    super.initState();
    SplashAds.loadInterstitialAd();
}
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
                            textStyle: splashYouTextStyle.copyWith(
                              fontSize: (size.width) * 0.3,
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
                                top: size.height * 0.20,
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      'VS',
                                      textStyle: splashVsTextStyle.copyWith(
                                        fontSize: size.width * 0.05,
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
                                      textStyle: splashAiTextStyle.copyWith(
                                        fontSize: size.width * 0.3,
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
                          style: AppTheme.splashButtonStyle.copyWith(
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(
                                vertical: size.height * 0.02,
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (SplashAds.isAdReady) {
                              SplashAds.showInterstitialAdWhen(
                                onAdClosed: () {
                                  Get.offAllNamed(AppRoutes.home);
                                },
                              );
                            } else {
                              Get.offAllNamed(AppRoutes.home);
                            }
                          },
                          // onPressed: () {
                          //   // if(SplashAds.isAdReady){
                          //   //   SplashAds.showInterstitialAd();
                          //   // }
                          //   Get.offAllNamed(AppRoutes.home);
                          // },
                          child: Text(
                            'Let\'s Go',
                            style: splashButtonTextStyle.copyWith(
                              fontSize: size.width * 0.05,
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
