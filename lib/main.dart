import 'package:flutter/material.dart';
import 'api_service.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customizable Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizSetupScreen(),
    );
  }
}

class QuizSetupScreen extends StatefulWidget {
  const QuizSetupScreen({super.key});

  @override
  _QuizSetupScreenState createState() => _QuizSetupScreenState();
}

class _QuizSetupScreenState extends State<QuizSetupScreen> {
  late Future<List<String>> categories;
  String? selectedCategory;
  int numberOfQuestions = 5;
  String difficulty = 'easy';
  String questionType = 'multiple';

  @override
  void initState() {
    super.initState();
    categories = ApiService().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Setup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder<List<String>>(
              future: categories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No categories found');
                }

                return DropdownButton<String>(
                  value: selectedCategory,
                  hint: const Text('Select Category'),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  items: snapshot.data!.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                );
              },
            ),
            // Dropdown for number of questions
            DropdownButton<int>(
              value: numberOfQuestions,
              onChanged: (int? newValue) {
                setState(() {
                  numberOfQuestions = newValue!;
                });
              },
              items: [5, 10, 15].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value questions'),
                );
              }).toList(),
            ),
            // Dropdown for difficulty level
            DropdownButton<String>(
              value: difficulty,
              onChanged: (String? newValue) {
                setState(() {
                  difficulty = newValue!;
                });
              },
              items: ['easy', 'medium', 'hard'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            // Dropdown for question type
            DropdownButton<String>(
              value: questionType,
              onChanged: (String? newValue) {
                setState(() {
                  questionType = newValue!;
                });
              },
              items: ['multiple', 'boolean'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value == 'multiple' ? 'Multiple Choice' : 'True/False'),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Proceed to fetch the quiz questions
                // Pass the selections to the next screen or function
              },
              child: const Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
