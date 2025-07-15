import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quiz_question_model.dart';

class ApiService {
  //final String _baseUrl = "https://api.mistral.ai/v1/";
  final String _apiKey = "Amhk9GcM4KM14dEXPQwrdVYC5FjwA8Ry";


  Future<List<QuizQuestion>> fetchQuizQuestions(String category) async {
    final response = await http.post(
      Uri.parse("https://api.mistral.ai/v1/chat/completions"),
      headers: {
        "Authorization": "Bearer $_apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "mistral-medium",
        "response_format": "json",
        "messages": [
          {
            "role": "system",
            "content": "You are a quiz generator. Only return a valid JSON array of questions. No extra explanation or text."
          },
          {
            "role": "user",
            "content": "Generate 10 multiple-choice questions for the '$category' category. Format each with: 'question', 'options', and 'answerIndex'."
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      try {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> list = jsonData['choices'][0]['message']['content'];

        return list.map((e) => QuizQuestion.fromJson(e)).toList();
      } catch (e) {
        throw Exception("Invalid JSON structure: $e");
      }
    } else {
      throw Exception("API Error: ${response.statusCode} ${response.reasonPhrase}");
    }
  }




}
