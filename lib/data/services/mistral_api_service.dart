import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/GlobalKey/global_key.dart';

class MistralApiService {
  static  final String _apiKey = global_key;
  static const _url = 'https://api.mistral.ai/v1/chat/completions';

  static Future<List<Map<String, dynamic>>> fetchQuestions(String category, int count) async {
    final prompt = '''
Generate a JSON array of $count quiz questions for the "$category" category.

Each object must strictly follow this format:
{
  "question": "Your question?",
  "options": ["A", "B", "C", "D"],
  "answer": 1
}

Important:
- Return ONLY a JSON array (no explanation or extra text)
- Options must be shuffled
- Answer index must be correct

Output:
''';

    final res = await http.post(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "mistral-medium",
        "messages": [{"role": "user", "content": prompt}],
      }),
    );

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }
    print("1");
    final resp = jsonDecode(res.body);
    final raw = resp['choices'][0]['message']['content'] as String;

    final match = RegExp(r'\[[\s\S]*\]').firstMatch(raw);
    if (match == null) {
      throw FormatException('No JSON array found in:\n$raw');
    }

    final jsonString = match.group(0)!;
    final list = jsonDecode(jsonString) as List;

    return list.cast<Map<String, dynamic>>();
  }

}
