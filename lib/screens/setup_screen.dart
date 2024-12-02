import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({Key? key}) : super(key: key);

  @override
  SetupScreenState createState() => SetupScreenState();
}

class SetupScreenState extends State<SetupScreen> {
  int _numberOfQuestions = 10;
  int _categoryId = 9; // General Knowledge
  String _difficulty = 'easy';
  String _questionType = 'multiple';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Setup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Number of Questions', style: Theme.of(context).textTheme.titleMedium),
            DropdownButton<int>(
              value: _numberOfQuestions,
              items: [5, 10, 15].map((value) {
                return DropdownMenuItem(value: value, child: Text('$value'));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _numberOfQuestions = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            Text('Category', style: Theme.of(context).textTheme.titleMedium),
            DropdownButton<int>(
              value: _categoryId,
              items: [
                DropdownMenuItem(value: 9, child: Text('General Knowledge')),
                DropdownMenuItem(value: 21, child: Text('Sports')),
                DropdownMenuItem(value: 23, child: Text('History')),
              ],
              onChanged: (value) {
                setState(() {
                  _categoryId = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            Text('Difficulty', style: Theme.of(context).textTheme.titleMedium),
            DropdownButton<String>(
              value: _difficulty,
              items: ['easy', 'medium', 'hard'].map((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _difficulty = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            Text('Question Type', style: Theme.of(context).textTheme.titleMedium),
            DropdownButton<String>(
              value: _questionType,
              items: ['multiple', 'boolean'].map((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _questionType = value!;
                });
              },
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(
                        amount: _numberOfQuestions,
                        category: _categoryId,
                        difficulty: _difficulty,
                        type: _questionType,
                      ),
                    ),
                  );
                },
                child: const Text('Start Quiz'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
