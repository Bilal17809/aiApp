import 'package:get/get.dart';
import 'package:ai_app/data/services/mistral_api_service.dart';
import 'package:ai_app/core/common_wgt/ai_feedback_messages.dart';
import '../../../core/utils/audio_player.dart';

class QuizController extends GetxController {
  final RxList<_QuizQuestion> questions = <_QuizQuestion>[].obs;
  final RxList<_QuizQuestion> preloadedQuestionQueue = <_QuizQuestion>[].obs;
  final RxInt currentQuestionIndex = 0.obs;
  final RxBool isLoading = false.obs;
  final RxInt selectedIndex = (-1).obs;
  final RxInt userSelectedIndex = (-1).obs;
  final RxInt aiCorrectedIndex = (-1).obs;
  final RxInt userScore = 0.obs;
  final RxInt aiScore = 0.obs;
  final RxInt wrongAnswersCount = 0.obs;
  final RxBool aiShouldHelp = false.obs;
  final RxBool isQuizCompleted = false.obs;
  final RxString aiMessage = ''.obs;
  final RxString selectedCategory = ''.obs;

  Future<void> loadQuestions(String category) async {
    if (isLoading.value) return;
    isLoading.value = true;

    selectedCategory.value = category;
    questions.clear();
    preloadedQuestionQueue.clear();
    selectedIndex.value =
        userScore.value = aiScore.value = currentQuestionIndex.value =
        wrongAnswersCount.value = userSelectedIndex.value =
        aiCorrectedIndex.value = 0;
    selectedIndex.value = userSelectedIndex.value = aiCorrectedIndex.value = -1;
    aiMessage.value = '';
    aiShouldHelp.value = isQuizCompleted.value = false;

    try {
      final list = await MistralApiService.fetchQuestions(category, 1);
      questions.add(_QuizQuestion(
        question: list[0]['question'],
        options: List<String>.from(list[0]['options']),
        answerIndex: list[0]['answer'],
      ));
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
    if (questions.length >= 10) {
      isQuizCompleted.value = true;
      return;
    }

    selectedIndex.value =
        userSelectedIndex.value = aiCorrectedIndex.value = -1;
    aiMessage.value = '';

    if (preloadedQuestionQueue.isNotEmpty) {
      questions.add(preloadedQuestionQueue.removeAt(0));
    } else {
      final list =
      await MistralApiService.fetchQuestions(selectedCategory.value, 1);
      questions.add(_QuizQuestion(
        question: list[0]['question'],
        options: List<String>.from(list[0]['options']),
        answerIndex: list[0]['answer'],
      ));
    }

    currentQuestionIndex.value++;
    _preloadNextQuestion();
  }

  void _preloadNextQuestion() async {
    if (questions.length + preloadedQuestionQueue.length >= 10) return;
    try {
      final list =
      await MistralApiService.fetchQuestions(selectedCategory.value, 1);
      preloadedQuestionQueue.add(_QuizQuestion(
        question: list[0]['question'],
        options: List<String>.from(list[0]['options']),
        answerIndex: list[0]['answer'],
      ));
    } catch (_) {}
  }

  void resetQuiz() {
    questions.clear();
    preloadedQuestionQueue.clear();
    currentQuestionIndex.value = userScore.value = aiScore.value =
        wrongAnswersCount.value = 0;
    selectedIndex.value = userSelectedIndex.value = aiCorrectedIndex.value = -1;
    isLoading.value = aiShouldHelp.value = isQuizCompleted.value = false;
    aiMessage.value = '';
  }

  void selectAnswer(int index) {
    if (selectedIndex.value != -1) return;
    final q = questions[currentQuestionIndex.value];

    userSelectedIndex.value = index;

    if (aiShouldHelp.value) {
      selectedIndex.value = aiCorrectedIndex.value = q.answerIndex;
      final fix = AIFeedbackMessages.getFixMessage();
      aiMessage.value = fix.text;
      SoundPlayer.play(fix.soundPath);
      userScore.value++;
      aiShouldHelp.value = false;
      wrongAnswersCount.value = 0;
    } else {
      selectedIndex.value = index;
      aiCorrectedIndex.value = -1;

      if (index == q.answerIndex) {
        userScore.value++;
        final praise = AIFeedbackMessages.getPraiseMessage();
        aiMessage.value = praise.text;
        SoundPlayer.play(praise.soundPath);
      } else {
        wrongAnswersCount.value++;
        aiScore.value++;
        final fb = AIFeedbackMessages.getRandomFeedback();
        aiMessage.value = fb.text;
        if (fb.soundPath.isNotEmpty) SoundPlayer.play(fb.soundPath);
        if (wrongAnswersCount.value >= 3) aiShouldHelp.value = true;
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

