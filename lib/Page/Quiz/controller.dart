import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late2023/Page/Quiz/question_data.dart';
import 'package:late2023/Page/Quiz/score_screen.dart';

// We use get package for our state management
class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Lets animated our progress bar

  late AnimationController _animationController;
  late Animation _animation;
  // So that we can access our animation outside
  Animation get animation => _animation;

  PageController? _pageController;
  PageController? get pageController => _pageController;

  // A dang zawng siam hnuah  helai hi code tur
  final List<Question> _questions = sample_data
      .map(
        (quest) => Question(
          id: quest['id'],
          question: quest['question'],
          answer: quest['answer_index'],
          options: quest['options'],
        ),
      )
      .toList();

  List<Question> get questions => _questions;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  int? _correctAns;
  int? get correctAns => _correctAns;

  late int _selectedAns;
  int get selectedAns => _selectedAns;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  late int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  @override
  void onInit() {
    // Our animation duration is 60s
    // So our plan is to fill the progress bar within 60s
    _animationController =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // a zawmna hi - Once 60s is completed go to the next Question.
    _animationController.forward().whenComplete(nextQuestion);

    _pageController = PageController();

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController?.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    //because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    //It will stop the counter
    _animationController.stop();
    update();

    Future.delayed(const Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;

      _pageController?.nextPage(
          duration: const Duration(microseconds: 250), curve: Curves.ease);

      // Reset the counter.
      _animationController.reset();

      // Then start it again
      // When timer is finish go to the next Question.
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      //Get package provide us simple way to navigate another page
      Get.to(
        () => const ScoreScreen(),
      );
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (BuildContext context) => const ScoreScreen()));
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
