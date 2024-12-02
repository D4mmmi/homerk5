import 'package:flutter/material.dart';
import '../services/api_service.dart';

class QuizScreen extends StatefulWidget {
  final int amount;
  final int category;
  final String difficulty;
  final String type;

  const QuizScreen({
    Key? key,
    required this.amount,
    required this.category,
    required this.difficulty,
    required this.type,
  }) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<List<Map<String, dynamic>>> _quizData;

  @override
  void initState() {
    super.initState();
    _quizData = ApiService().fetchQuiz(
      amount: widget.amount,
      category: widget.category,
      difficulty: widget.difficulty,
      type: widget.type,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _quizData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No questions found.'));
          }

          final questions = snapshot.data!;
          return QuizContent(questions: questions);
        },
      ),
    );
  }
}

class QuizContent extends StatelessWidget {
  final List<Map<String, dynamic>> questions;

  QuizContent({required this.questions});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Implement the quiz logic here!'),
    );
  }
}
