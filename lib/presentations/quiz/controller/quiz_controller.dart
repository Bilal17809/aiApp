import 'package:get/get.dart';
import 'package:ai_app/data/services/api_service.dart';

import '../view/quiz_result_page.dart';

class QuizQuestion {
  final String question;
  final List<String> options;
  final int answerIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.answerIndex,
  });
}
class QuizController extends GetxController {
  final RxList<QuizQuestion> questions = <QuizQuestion>[].obs;
  final RxInt currentQuestionIndex = 0.obs;
  final RxBool isLoading = false.obs;
  final RxInt selectedIndex = (-1).obs;
  final RxInt userScore = 0.obs;
  final RxInt aiScore = 0.obs;
  final RxInt wrongAnswersCount = 0.obs;
  final RxBool aiShouldHelp = false.obs;
  final RxString aiMessage = ''.obs;
  Future<void> loadQuestions(String category) async {
    if (isLoading.value) return;
    isLoading.value = true;

    questions.clear();
    selectedIndex.value = -1;
    userScore.value = 0;
    aiScore.value = 0;
    currentQuestionIndex.value = 0;
    wrongAnswersCount.value=0;
    aiShouldHelp.value=false;
    try {
      final questionsList = await ApiService.fetchQuestions(category, 5);

      questions.assignAll(questionsList.map((q) => QuizQuestion(
        question: q['question'],
        options: List<String>.from(q['options']),
        answerIndex: q['answer'],
      )));
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  void nextQuestion() {
    aiMessage.value = '';

    if (currentQuestionIndex.value + 1 < questions.length) {
      currentQuestionIndex.value++;
      selectedIndex.value = -1;
    } else {
      Get.off(() => const QuizResultPage());

    }
  }
  void resetQuiz() {
    questions.clear();
    currentQuestionIndex.value = 0;
    userScore.value = 0;
    wrongAnswersCount.value=0;
    aiScore.value = 0;
    selectedIndex.value = -1;
    isLoading.value = false;
  }
  void selectAnswer(int index) {
    if (selectedIndex.value != -1) return;

    final currentQuestion = questions[currentQuestionIndex.value];

    if (aiShouldHelp.value) {
      selectedIndex.value = currentQuestion.answerIndex;
      userScore.value += 10;
      aiMessage.value = "Oops! Let me fix that one for you 😉";
      aiShouldHelp.value = false;
      wrongAnswersCount.value = 0;

    } else {
      selectedIndex.value = index;

      if (index == currentQuestion.answerIndex) {
        userScore.value += 10;
        aiMessage.value = "Nice one! You're getting smarter 🤓";
      } else {
        wrongAnswersCount.value++;
        aiScore.value += 10;
        final messageIndex = (wrongAnswersCount.value - 1).clamp(0, 3);
        aiMessage.value = [
          "Hmm... interesting choice 😅",
          "You sure about that? 🤔",
          "Don't worry, even AI makes mistakes 🧠",
          "That's not quite right... again 😬",

        ][messageIndex];

        if (wrongAnswersCount.value >= 3) {
          aiShouldHelp.value = true;
        }
      }
    }


    Future.delayed(const Duration(seconds: 2), nextQuestion);
  }
}
