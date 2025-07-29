import 'package:ai_app/presentations/Ads/splash_interstitial.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:ai_app/data/services/mistral_api_service.dart';
import '../../../core/common_wgt/no_internet_dialog.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/audio_player.dart';
import '../../../data/data_sources/ai_feedback_loader.dart';
import '../../Ads/Banner/controller/banner_ad_controller.dart';
import '../../Ads/Interstitial/controller/interstitial_ad_controller.dart';
import '../../quiz_result_screen/view/quiz_result_page.dart';

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
  final SplashAds=Get.find<SplashInterstitialAdController>();
  final IntertialAds=Get.find<InterstitialAdController>();
  final BannerAdController adController = Get.put(BannerAdController());


  @override
  void onReady() {
    super.onReady();
    adController.loadBannerAd('ad2');
    if(IntertialAds.isAdReady.value){
      IntertialAds.checkAndShowAd();
    }
  }

  @override
  void onInit() {
    super.onInit();
    SplashAds.loadInterstitialAd();
    AIFeedbackLoader().loadMessages();
    ever(isQuizCompleted, (completed) {
      if (completed == true) {
        Future.delayed(const Duration(milliseconds: 200), () {
       Get.off(() => const QuizResultPage());
        });
      }
    });
  }

  Future<bool> hasInternetConnection() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Future<void> loadQuestions(String category) async {
    if (isLoading.value) return;
    isLoading.value = true;
    AIFeedbackLoader().resetUsedIndexes();

    selectedCategory.value = category;
    questions.clear();
    preloadedQuestionQueue.clear();

    selectedIndex.value =
        userScore.value =
            aiScore.value =
                currentQuestionIndex.value =
                    wrongAnswersCount.value =
                        userSelectedIndex.value = aiCorrectedIndex.value = 0;
    selectedIndex.value = userSelectedIndex.value = aiCorrectedIndex.value = -1;
    aiMessage.value = '';
    aiShouldHelp.value = isQuizCompleted.value = false;

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

    selectedIndex.value = userSelectedIndex.value = aiCorrectedIndex.value = -1;
    aiMessage.value = '';

    if (preloadedQuestionQueue.isNotEmpty) {
      questions.add(preloadedQuestionQueue.removeAt(0));
    } else {
      final isConnected = await hasInternetConnection();
      if (!isConnected) {
        Get.dialog(
          NoInternetDialog(
            title: 'No Internet',
            message: 'Can\'t load more questions without internet.',
            button_text: 'Retry',
            onRetry: () {
              Get.back();
              checkAndFinishQuiz();
            },
            secondaryButtonText: 'Exit',
            onSecondary: () {
              Get.back();
              Get.offAllNamed(AppRoutes.home);
            },
          ),
          barrierDismissible: false,
        );
        return;
      }

      try {
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
      } catch (_) {
        Get.dialog(
          NoInternetDialog(
            title: 'Error',
            message: 'Something went wrong. Please try again.',
            onRetry: () {
              Get.back();
              checkAndFinishQuiz();
            },
          ),
        );
        return;
      }
    }

    currentQuestionIndex.value++;
    _preloadNextQuestion();
  }

  void _preloadNextQuestion() async {
    if (questions.length + preloadedQuestionQueue.length >= 10) return;

    final isConnected = await hasInternetConnection();
    if (!isConnected) return;

    try {
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
    preloadedQuestionQueue.clear();
    currentQuestionIndex.value =
        userScore.value = aiScore.value = wrongAnswersCount.value = 0;
    selectedIndex.value = userSelectedIndex.value = aiCorrectedIndex.value = -1;
    isLoading.value = aiShouldHelp.value = isQuizCompleted.value = false;
    aiMessage.value = '';
  }

  // void selectAnswer(int index) {
  //   if (selectedIndex.value != -1) return;
  //   final q = questions[currentQuestionIndex.value];
  //   final loader = AIFeedbackLoader();
  //   userSelectedIndex.value = index;
  //
  //   if (aiShouldHelp.value && index != q.answerIndex) {
  //     selectedIndex.value = aiCorrectedIndex.value = q.answerIndex;
  //
  //     final fix = loader.getFixMessage();
  //     aiMessage.value = fix.text;
  //     SoundPlayer.play(fix.soundPath);
  //
  //     userScore.value++;
  //     aiShouldHelp.value = false;
  //     wrongAnswersCount.value = 0;
  //   } else {
  //     selectedIndex.value = index;
  //     aiCorrectedIndex.value = -1;
  //
  //     if (index == q.answerIndex) {
  //       userScore.value++;
  //
  //       final praise = loader.getCorrectMessage();
  //       aiMessage.value = praise.text;
  //       SoundPlayer.play(praise.soundPath);
  //     } else {
  //       wrongAnswersCount.value++;
  //       aiScore.value++;
  //
  //       final feedback = loader.getIncorrectMessage();
  //       aiMessage.value = feedback.text;
  //
  //       if (feedback.soundPath.isNotEmpty) {
  //         SoundPlayer.play(feedback.soundPath);
  //       }
  //
  //       if (wrongAnswersCount.value >= 3) {
  //         aiShouldHelp.value = true;
  //       }
  //     }
  //   }
  //   Future.delayed(const Duration(seconds: 4), checkAndFinishQuiz);
  //   // If current question index is 2 (i.e. 3rd question), show ad then play sound
  //   if (currentQuestionIndex.value == 2) {
  //     Get.find<SplashInterstitialAdController>().showInterstitialAdWhen(
  //       onAdClosed: () {
  //         playFeedbackSound();
  //       },
  //     );
  //   } else {
  //     playFeedbackSound();
  //   }
  // }
  void playFeedbackForAnswer(int index) {
    final q = questions[currentQuestionIndex.value];
    final loader = AIFeedbackLoader();

    if (aiShouldHelp.value && index != q.answerIndex) {
      selectedIndex.value = aiCorrectedIndex.value = q.answerIndex;

      final fix = loader.getFixMessage();
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

        final praise = loader.getCorrectMessage();
        aiMessage.value = praise.text;
        SoundPlayer.play(praise.soundPath);
      } else {
        wrongAnswersCount.value++;
        aiScore.value++;

        final feedback = loader.getIncorrectMessage();
        aiMessage.value = feedback.text;

        if (feedback.soundPath.isNotEmpty) {
          SoundPlayer.play(feedback.soundPath);
        }

        if (wrongAnswersCount.value >= 3) {
          aiShouldHelp.value = true;
        }
      }
    }

    Future.delayed(const Duration(seconds: 4), checkAndFinishQuiz);
  }
  void selectAnswer(int index) {
    if (selectedIndex.value != -1) return;
    userSelectedIndex.value = index;

    if (currentQuestionIndex.value == 5 && Get.find<SplashInterstitialAdController>().isAdReady) {
      Get.find<SplashInterstitialAdController>().showInterstitialAdWhen(
        onAdClosed: () {
          playFeedbackForAnswer(index);
        },
      );
    } else {
      playFeedbackForAnswer(index);
    }
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
