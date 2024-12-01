import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://opentdb.com/api.php?amount=10&category=9&difficulty=easy&type=multiple';

  Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/api_category.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> categories = data['trivia_categories'];

      return categories.map((category) => category['name'] as String).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Add methods for fetching questions (we'll get to this soon)
}
