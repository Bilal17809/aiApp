import 'package:ai_app/presentations/Ads/Banner/controller/banner_ad_controller.dart';
import 'package:ai_app/presentations/Ads/Interstitial/controller/interstitial_ad_controller.dart';
import 'package:ai_app/presentations/Ads/ad_open_App/controller/open_ad_controller.dart';
import 'package:ai_app/presentations/Ads/onesignal.dart';
import 'package:ai_app/presentations/Ads/splash_interstitial.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  Get.put(AppOpenAdController());
  Get.put(SplashInterstitialAdController());
  Get.put(InterstitialAdController());
  Get.put(BannerAdController());
  initializeOneSignal();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: appPages,
    );
  }
}
