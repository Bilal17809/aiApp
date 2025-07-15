import 'package:ai_app/core/bindings/app_binding.dart';
import 'package:ai_app/presentations/home/view/home_page.dart';
import 'package:get/get.dart';

import '../../presentations/quiz/view/quiz_result_page.dart';
import 'app_routes.dart';

final List<GetPage> appPages=[
  GetPage(
      name: AppRoutes.home,
      page:()=>HomePage(),

    binding: HomeBinding(),
  ),
  GetPage(
    name: '/quiz-result',
    page: () => const QuizResultPage(),
  ),
];