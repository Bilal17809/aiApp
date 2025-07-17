// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../core/GlobalKey/global_key.dart';
//
// class MistralApiService {
//   static final String _apiKey = global_key;
//   static const String _url = 'https://api.mistral.ai/v1/chat/completions';
//
//   static Future<List<Map<String, dynamic>>> fetchQuestions(String category, int count) async {
//     final now = DateTime.now().millisecondsSinceEpoch;
//     final subTopicHint = _randomHintByCategory(category);
//
//     final prompt = '''
// Generate a JSON array of 5 **unique and creative quiz questions** for the "$category" category. Focus more on "$subTopicHint".
//
// Strict format for each item:
// {
//   "question": "Your question?",
//   "options": ["Option A", "Option B", "Option C", "Option D"],
//   "answer": 1
// }
//
// Instructions:
// - DO NOT repeat previous questions.
// - Shuffle options randomly.
// - Ensure the "answer" index points to the correct one.
// - Include easy, medium, and hard levels.
// - Return ONLY a pure JSON array (no explanation).
//
// Uniqueness hint: [$now]
// ''';
//
//     final res = await http.post(
//       Uri.parse(_url),
//       headers: {
//         'Authorization': 'Bearer $_apiKey',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "model": "mistral-medium",
//         "messages": [
//           {"role": "user", "content": prompt}
//         ],
//       }),
//     );
//
//     if (res.statusCode != 200) {
//       throw Exception('HTTP ${res.statusCode}: ${res.body}');
//     }
//
//     final body = jsonDecode(res.body);
//     final raw = body['choices'][0]['message']['content'] as String;
//
//     final match = RegExp(r'\[[\s\S]*\]').firstMatch(raw);
//     if (match == null) {
//       throw FormatException('No valid JSON array found in:\n$raw');
//     }
//
//     final jsonString = match.group(0)!;
//     final list = jsonDecode(jsonString) as List;
//
//     return list.cast<Map<String, dynamic>>();
//   }
//
//
//   static String _randomHintByCategory(String category) {
//     final lower = category.toLowerCase();
//     final timestamp = DateTime.now().second;
//
//     if (lower.contains("science")) {
//       const scienceHints = ['biology', 'space', 'physics', 'chemistry'];
//       return scienceHints[timestamp % scienceHints.length];
//     } else if (lower.contains("history")) {
//       const historyHints = ['world wars', 'ancient civilizations', 'leaders', 'empires'];
//       return historyHints[timestamp % historyHints.length];
//     } else if (lower.contains("word")) {
//       const wordHints = ['synonyms', 'antonyms', 'idioms', 'vocabulary'];
//       return wordHints[timestamp % wordHints.length];
//     } else {
//       const generalHints = ['geography', 'inventions', 'current affairs', 'records'];
//       return generalHints[timestamp % generalHints.length];
//     }
//   }
// }

/*

create quiz using only prompt
here you create json etc?????
then return that json why you create json
we need simple prompt message

2. on first launch when user enter the quiz
load just 2,3, await a bit  which you already
give to navigate automitically
*/
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/GlobalKey/global_key.dart';

class MistralApiService {
  static final String _apiKey = global_key;
  static const String _url = 'https://api.mistral.ai/v1/chat/completions';

  static Future<List<Map<String, dynamic>>> fetchQuestions(String category, int count) async {
    final hint = _getHint(category);
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final prompt = '''
Generate a JSON array of 1 quiz questions for "$category", focusing on "$hint".

Format:
{
  "question": "Your question?",
  "options": ["Option A", "Option B", "Option C", "Option D"],
  "answer": 1
}

- Return only the pure JSON array.
- Options must be shuffled.
- Include a mix of difficulty levels.
- Ensure the answer index is correct.

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
    final jsonMatch = RegExp(r'\[[\s\S]*\]').firstMatch(content);

    if (jsonMatch == null) {
      throw FormatException('Invalid response format:\n$content');
    }

    return (jsonDecode(jsonMatch.group(0)!) as List).cast<Map<String, dynamic>>();
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
