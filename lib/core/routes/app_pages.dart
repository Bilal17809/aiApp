import 'package:get/get.dart';
import '../../presentations/Facts/bindings/fact_binding.dart';
import '../../presentations/Facts/view/fact_page.dart';
import '../../presentations/home/view/home_page.dart';
import '../../presentations/quiz_result_screen/view/quiz_result_page.dart';
import '../../presentations/splash/view/splash_screen.dart';
import '../bindings/app_binding.dart';
import 'app_routes.dart';

final List<GetPage> appPages = [
  GetPage(
    name: AppRoutes.splash,
    page: () => SplashScreen(),
  ),
  GetPage(
    name: AppRoutes.home,
    page: () => const HomePage(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: AppRoutes.quizResult,
    page: () => const QuizResultPage(),
  ),
  GetPage(
      name: AppRoutes.facts,
      page: () => FactPage(),
      binding: FactBinding(),
  ),
];
