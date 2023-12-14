import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late2023/Page/Quiz/controller.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController qnController = Get.put(QuestionController());
    int scored = qnController.correctAns ?? 0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.green,
          ),
          Column(
            children: [
              const Spacer(
                flex: 3,
              ),
              const Text(
                "Score",
                style: TextStyle(color: Colors.black, fontSize: 50),
              ),
              const Spacer(),
              Text(
                "${scored * 10}/${qnController.questions.length * 10}",
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 15,
                ),
              ),
              const Spacer(
                flex: 3,
              ),
            ],
          )
        ],
      ),
    );
  }
}
