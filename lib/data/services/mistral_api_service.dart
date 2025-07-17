import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/GlobalKey/global_key.dart';

class MistralApiService {
  static final String _apiKey = global_key;
  static const String _url = 'https://api.mistral.ai/v1/chat/completions';

  static Future<List<Map<String, dynamic>>> fetchQuestions(String category, int count) async {
    count=10;
    final hint = _getHint(category);
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final prompt = '''
Generate $count quiz questions about "$category", focusing on "$hint".

Respond in this plain text format (no JSON):
Q: What is the capital of France?
A. Berlin
B. Madrid
C. Paris
D. Rome
Answer: C

Rules:
- Return exactly $count questions in this format.
- Randomize the order of the options.
- Provide only plain text in this format — do not return JSON.
- Use a mix of difficulties.
[$timestamp]
''';

    final res = await http.post(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "mistral-medium",
        "messages": [
          {"role": "user", "content": prompt}
        ],
      }),
    );

    if (res.statusCode != 200) {
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
    final base = category.toLowerCase();
    final hints = {
      "science": ['biology', 'space', 'physics', 'chemistry'],
      "history": ['world wars', 'ancient civilizations', 'leaders', 'empires'],
      "word": ['synonyms', 'antonyms', 'idioms', 'vocabulary'],
    };

    final fallback = ['geography', 'inventions', 'current affairs', 'records'];
    final list = hints.entries.firstWhere(
          (e) => base.contains(e.key),
      orElse: () => MapEntry('other', fallback),
    ).value;

    return list[DateTime.now().second % list.length];
  }
}
