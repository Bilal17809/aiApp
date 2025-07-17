import 'dart:math';

class AIFeedbackMessages {
  static const List<AIFeedbackMessage> feedbackList = [
    AIFeedbackMessage(
      text: "Hmm... interesting choice 😅",
      soundPath: 'feedbacksounds/interesting_choice.mp3'
    ),
    AIFeedbackMessage(
      text: "You sure about that? 🤔",
        soundPath: 'feedbacksounds/sure_about.mp3'
    ),
    AIFeedbackMessage(
      text: "Don't worry, even AI makes mistakes 🧠",
        soundPath: 'feedbacksounds/Ai_mistakes.mp3'
    ),
    // _AIFeedbackMessage(
    //   text: "That's not quite right... again 😬",
    //     soundPath: 'assets/feedbacksounds/choice.mp3'
    // ),
    AIFeedbackMessage(
      text: "Try thinking like an AI 🧠💡",
        soundPath: 'feedbacksounds/try_thinking.mp3'
    ),

    AIFeedbackMessage(
      text: "Next time, just trust me 😎",
        soundPath: 'feedbacksounds/trust_me.mp3'
    ),
    // _AIFeedbackMessage(
    //   text: "Careful... I’m catching up! 🤖",
    //     soundPath: 'assets/feedbacksounds/choice.mp3'
    // ),
    // _AIFeedbackMessage(
    //   text: "It's okay, quizzes are tough 😌",
    //     soundPath: 'assets/feedbacksounds/choice.mp3'
    // ),
    // _AIFeedbackMessage(
    //   text: "Wrong again? Are you trolling me? 😂",
    //     soundPath: 'assets/feedbacksounds/choice.mp3'
    // ),
    AIFeedbackMessage(
      text: "I’d offer help, but this is more fun 😈",
        soundPath: 'feedbacksounds/more_fun.mp3'
    ),
    // _AIFeedbackMessage(
    //   text: "Boom! Nailed it 💥",
    //     soundPath: 'assets/feedbacksounds/choice.mp3'
    // ),
    // _AIFeedbackMessage(
    //   text: "Now that’s what I call a comeback! 🔥",
    //     soundPath: 'assets/feedbacksounds/choice.mp3'
    // ),
    // _AIFeedbackMessage(
    //   text: "You just AI-clapped me 😮",
    //     soundPath: 'assets/feedbacksounds/choice.mp3'
    // ),
  ];

  static AIFeedbackMessage getRandomFeedback() {
    final randomIndex = Random().nextInt(feedbackList.length);
    return feedbackList[randomIndex];
  }

  static AIFeedbackMessage getFixMessage() {
    return AIFeedbackMessage(
      text: "Oops! Let me fix that one for you 😉",
      soundPath: "feedbacksounds/fix_forYou.mp3",
    );
  }

  static AIFeedbackMessage getPraiseMessage() {
    return AIFeedbackMessage(
      text: "Nice one! You're getting smarter 🤓",
      soundPath: "feedbacksounds/getting_smarter.mp3",
    );
  }



}

class AIFeedbackMessage {
  final String text;
  final String soundPath;

  const AIFeedbackMessage({
    required this.text,
    required this.soundPath,
  });
}
