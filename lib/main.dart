import 'package:ai_app/presentations/Ads/ad_open_App/controller/open_ad_controller.dart';
import 'package:ai_app/presentations/quiz/controller/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  Get.put(AppOpenAdController());
  Get.put(QuizController());
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
