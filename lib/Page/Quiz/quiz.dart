import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late2023/Page/Quiz/body.dart';
import 'package:late2023/Page/Quiz/controller.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuestionController _controller = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _controller.nextQuestion,
            child: const Text('Skip'),
          ),
        ],
      ),
      body: const QuizBody(),
    );
  }
}
