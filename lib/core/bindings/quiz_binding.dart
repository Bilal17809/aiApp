import 'package:get/get.dart';

import '../../presentations/quiz_screen/controller/quiz_controller.dart';

class QuizBinding extends Bindings {
  final String category;

  QuizBinding(this.category);

  @override
  void dependencies() {
    final controller = Get.put(QuizController());
    controller.loadQuestions(category);
  }
}
