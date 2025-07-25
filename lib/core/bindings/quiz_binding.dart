import 'package:get/get.dart';
import '../../presentations/quiz_screen/controller/quiz_controller.dart';

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizController>(() => QuizController());
  }
}
