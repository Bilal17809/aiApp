import 'dart:convert';
import 'package:flutter/services.dart';

class AIFeedbackLoader {
  late List<FeedbackMessage> correctMessages;
  late List<FeedbackMessage> incorrectMessages;
  late List<FeedbackMessage> fixMessages;
  final List<int> _usedFixIndexes = [];


  final List<int> _usedCorrectIndexes = [];
  final List<int> _usedIncorrectIndexes = [];

  static final AIFeedbackLoader _instance = AIFeedbackLoader._internal();
  factory AIFeedbackLoader() => _instance;
  AIFeedbackLoader._internal();

  Future<void> loadMessages() async {
    final jsonString = await rootBundle.loadString('assets/files/ai_feedback_messages.json');
    final jsonMap = json.decode(jsonString);

    correctMessages = List<Map<String, dynamic>>.from(jsonMap['correctMessages'])
        .map((msg) => FeedbackMessage.fromJson(msg)).toList();

    incorrectMessages = List<Map<String, dynamic>>.from(jsonMap['incorrectMessages'])
        .map((msg) => FeedbackMessage.fromJson(msg)).toList();

    correctMessages.shuffle();
    incorrectMessages.shuffle();

    fixMessages = List<Map<String, dynamic>>.from(jsonMap['fixMessages'])
        .map((msg) => FeedbackMessage.fromJson(msg)).toList();
    fixMessages.shuffle();

  }

  FeedbackMessage getCorrectMessage() {
    for (int i = 0; i < correctMessages.length; i++) {
      if (!_usedCorrectIndexes.contains(i)) {
        _usedCorrectIndexes.add(i);
        return correctMessages[i];
      }
    }

    return correctMessages.last;
  }

  FeedbackMessage getIncorrectMessage() {
    for (int i = 0; i < incorrectMessages.length; i++) {
      if (!_usedIncorrectIndexes.contains(i)) {
        _usedIncorrectIndexes.add(i);
        return incorrectMessages[i];
      }
    }

    return incorrectMessages.last;
  }

  FeedbackMessage getFixMessage() {
    for (int i = 0; i < fixMessages.length; i++) {
      if (!_usedFixIndexes.contains(i)) {
        _usedFixIndexes.add(i);
        return fixMessages[i];
      }
    }
    return fixMessages.last;
  }

  void resetUsedIndexes() {
    _usedCorrectIndexes.clear();
    _usedIncorrectIndexes.clear();
    _usedFixIndexes.clear();
  }

}


class FeedbackMessage {
  final String text;
  final String soundPath;

  FeedbackMessage({required this.text, required this.soundPath});

  factory FeedbackMessage.fromJson(Map<String, dynamic> json) {
    return FeedbackMessage(
      text: json['text'],
      soundPath: json['soundPath'],
    );
  }
}
