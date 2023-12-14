import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late2023/Page/Quiz/controller.dart';
import 'package:late2023/Page/Quiz/progressbar.dart';
import 'package:late2023/Page/Quiz/question_card.dart';

class QuizBody extends StatefulWidget {
  const QuizBody({super.key});

  @override
  State<QuizBody> createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody> {
  //So that we have access our controller question
  final QuestionController _questionController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ProgressBar(),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
                () => Text.rich(
                  TextSpan(
                    text:
                        "Question ${_questionController.questionNumber.value}",
                    style: const TextStyle(color: Colors.red, fontSize: 20),
                    children: [
                      TextSpan(
                          text: "/${_questionController.questions.length}",
                          style:
                              TextStyle(color: Colors.red[200], fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              thickness: 1.5,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: PageView.builder(
                // Block swipe to next Question
                physics: const NeverScrollableScrollPhysics(),
                controller: _questionController.pageController,
                onPageChanged: _questionController.updateTheQnNum,
                itemCount: _questionController.questions.length,
                itemBuilder: (context, index) => QuestionCard(
                  question: _questionController.questions[index],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
