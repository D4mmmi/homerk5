import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://opentdb.com/api.php?amount=10&category=9&difficulty=easy&type=multiple';

  Future<List<Map<String, dynamic>>> fetchQuiz({
    required int amount,
    required int category,
    required String difficulty,
    required String type,
  }) async {
    final url = Uri.parse(
        '$_baseUrl/api.php?amount=$amount&category=$category&difficulty=$difficulty&type=$type');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List;
      return results.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load quiz data');
    }
  }
}
