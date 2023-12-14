import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late2023/Page/Quiz/controller.dart';
import 'package:late2023/Page/Quiz/question_data.dart';
import 'package:late2023/Page/Quiz/question_option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    // hetah hian parameter pass a ngai tih kan hriattirna tur.
    required this.question,
  });

// Question kan declare
  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController controller = Get.put(QuestionController());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question.question,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          ...List.generate(
            question.options.length,
            (index) => Options(
              text: question.options[index],
              index: index,
              press: () => controller.checkAns(question, index),
            ),
          ),
          // const Options(),
          // const Options(),
          // const Options(),
          // const Options(),
        ],
      ),
    );
  }
}
