import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/GlobalKey/global_key.dart';
import '../../core/constants/constants.dart';

class MistralApiService {
  static final String _apiKey = global_key;
  static const String _url = 'https://api.mistral.ai/v1/chat/completions';
  static final Map<String, int> _hintIndices = {};

  static Future<List<Map<String, dynamic>>> fetchQuestions(String category, int count) async {

    final hint = _getHint(category);
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final randomizer = DateTime.now().microsecondsSinceEpoch % 1000;

    final prompt = '''
Generate $count quiz questions about "$category", focusing on "$hint".

Each question must be different from the previous question generated at [$timestamp] (ID: $randomizer).

Follow this plain text format (no JSON):
Q: What is the capital of France?
A. Berlin
B. Madrid
C. Paris
D. Rome
Answer: C

Rules:
- Return exactly $count unique questions in this format.
- Ensure the questions are fresh and not commonly repeated.
- Randomize the order of the options.
- Provide only plain text in this format — do not return JSON.
- Use a mix of difficulties (easy/medium/hard).
''';


    final res = await http.post(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "mistral-small",
        "messages": [
          {"role": "user", "content": prompt}
        ],
      }),
    );

    if (res.statusCode != 200) {
      print('${res.statusCode}: ${res.body}');
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final content = jsonDecode(res.body)['choices'][0]['message']['content'] as String;

    return _parseQuestionsFromText(content);
  }

  static List<Map<String, dynamic>> _parseQuestionsFromText(String input) {
    final lines = LineSplitter.split(input).toList();
    final List<Map<String, dynamic>> questions = [];

    for (int i = 0; i < lines.length;) {
      if (!lines[i].startsWith('Q:')) {
        i++;
        continue;
      }

      final question = lines[i].substring(2).trim();
      if (i + 5 >= lines.length) break;

      final options = [
        lines[i + 1].substring(2).trim(),
        lines[i + 2].substring(2).trim(),
        lines[i + 3].substring(2).trim(),
        lines[i + 4].substring(2).trim(),
      ];

      final answerLine = lines[i + 5];
      final correctLetter = answerLine.split('Answer:').last.trim();
      final answerIndex = ['A', 'B', 'C', 'D'].indexOf(correctLetter);

      questions.add({
        "question": question,
        "options": options,
        "answer": answerIndex,
      });

      i += 6;
    }

    return questions;
  }




  static String _getHint(String category) {
    final key = hints.keys.firstWhere(
          (k) => category.toLowerCase().contains(k),
      orElse: () => 'general',
    );

    final list = hints[key]!;
    final index = (_hintIndices[key] ?? 0) % list.length;


    _hintIndices[key] = index + 1;

    return list[index];
  }


}
