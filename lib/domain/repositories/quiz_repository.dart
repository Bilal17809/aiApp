import '../../data/models/quiz_question_model.dart';
import '../../data/services/api_service.dart';

class QuizRepository {
  final ApiService _api = ApiService();

  Future<List<QuizQuestion>> getQuestions(String category) {
    return _api.fetchQuizQuestions(category);
  }
}
