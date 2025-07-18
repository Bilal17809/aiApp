import 'package:get/get.dart';
import 'package:ai_app/data/services/mistral_api_service.dart';
import 'package:ai_app/core/common_wgt/ai_feedback_messages.dart';

import '../../../core/utils/audio_player.dart';

class QuizController extends GetxController {
  final RxList<_QuizQuestion> questions = <_QuizQuestion>[].obs;
  final RxInt currentQuestionIndex = 0.obs;
  final RxBool isLoading = false.obs;
  final RxInt selectedIndex = (-1).obs;
  final RxInt userScore = 0.obs;
  final RxInt aiScore = 0.obs;
  final RxInt wrongAnswersCount = 0.obs;
  final RxBool aiShouldHelp = false.obs;
  final RxString aiMessage = ''.obs;
  final isQuizCompleted = false.obs;
  final RxList<_QuizQuestion> preloadedQuestionQueue = <_QuizQuestion>[].obs;
  final RxString selectedCategory = ''.obs;


  @override
  void onInit() {
    super.onInit();
  }

  Future<void> loadQuestions(String category) async {
    if (isLoading.value) return;

    isLoading.value = true;
    selectedCategory.value = category;

    aiMessage.value = '';
    questions.clear();
    preloadedQuestionQueue.clear();
    selectedIndex.value = -1;
    userScore.value = 0;
    aiScore.value = 0;
    currentQuestionIndex.value = 0;
    wrongAnswersCount.value = 0;
    aiShouldHelp.value = false;
    isQuizCompleted.value = false;

    try {
      final list = await MistralApiService.fetchQuestions(category, 1);
      questions.add(
        _QuizQuestion(
          question: list[0]['question'],
          options: List<String>.from(list[0]['options']),
          answerIndex: list[0]['answer'],
        ),
      );

      _preloadNextQuestion();
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
    }
  }

  void checkAndFinishQuiz() async {
    final isLast = questions.length >= 10;

    if (isLast) {
      isQuizCompleted.value = true;
      return;
    }

    if (preloadedQuestionQueue.isNotEmpty) {
      questions.add(preloadedQuestionQueue.removeAt(0));
      currentQuestionIndex.value++;

      _preloadNextQuestion();
    } else {
      final list = await MistralApiService.fetchQuestions(
        selectedCategory.value,
        1,
      );
      questions.add(
        _QuizQuestion(
          question: list[0]['question'],
          options: List<String>.from(list[0]['options']),
          answerIndex: list[0]['answer'],
        ),
      );
      currentQuestionIndex.value++;
    }

    selectedIndex.value = -1;
    aiMessage.value = '';
  }

  void _preloadNextQuestion() async {
    try {
      if (questions.length + preloadedQuestionQueue.length >= 10) return;

      final list = await MistralApiService.fetchQuestions(
        selectedCategory.value,
        1,
      );
      preloadedQuestionQueue.add(
        _QuizQuestion(
          question: list[0]['question'],
          options: List<String>.from(list[0]['options']),
          answerIndex: list[0]['answer'],
        ),
      );
    } catch (_) {}
  }

  void resetQuiz() {
    questions.clear();
    currentQuestionIndex.value = 0;
    userScore.value = 0;
    wrongAnswersCount.value = 0;
    aiScore.value = 0;
    selectedIndex.value = -1;
    isLoading.value = false;
  }

  void selectAnswer(int index) {
    if (selectedIndex.value != -1) return;

    final currentQuestion = questions[currentQuestionIndex.value];

    if (aiShouldHelp.value) {
      selectedIndex.value = currentQuestion.answerIndex;
      userScore.value += 1;
      final fixMsg = AIFeedbackMessages.getFixMessage();
      aiMessage.value = fixMsg.text;
      SoundPlayer.play(fixMsg.soundPath);

      aiShouldHelp.value = false;
      wrongAnswersCount.value = 0;
    } else {
      selectedIndex.value = index;

      if (index == currentQuestion.answerIndex) {
        userScore.value += 1;
        final praiseMsg = AIFeedbackMessages.getPraiseMessage();
        aiMessage.value = praiseMsg.text;
        SoundPlayer.play(praiseMsg.soundPath);
      } else {
        wrongAnswersCount.value++;
        aiScore.value += 1;

        final feedback = AIFeedbackMessages.getRandomFeedback();
        aiMessage.value = feedback.text;

        if (feedback.soundPath.isNotEmpty) {
          SoundPlayer.play(feedback.soundPath);
        }

        if (wrongAnswersCount.value >= 3) {
          aiShouldHelp.value = true;
        }
      }
    }

    Future.delayed(const Duration(seconds: 3), checkAndFinishQuiz);
  }
}

class _QuizQuestion {
  final String question;
  final List<String> options;
  final int answerIndex;

  _QuizQuestion({
    required this.question,
    required this.options,
    required this.answerIndex,
  });
}
