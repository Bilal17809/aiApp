import 'package:get/get.dart';
import 'package:ai_app/presentations/quiz/controller/quiz_controller.dart';

class QuizBinding extends Bindings {
  final String category;

  QuizBinding(this.category);

  @override
  void dependencies() {
    final controller = Get.put(QuizController());
    controller.loadQuestions(category);
  }
}
