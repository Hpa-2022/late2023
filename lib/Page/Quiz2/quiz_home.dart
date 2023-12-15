import 'dart:async';

import 'package:flutter/material.dart';
import 'package:late2023/Page/Quiz2/data.dart';
import 'package:late2023/Page/Quiz2/model.dart';
import 'package:late2023/Page/Quiz2/score.dart';

class QuizSecondHome extends StatefulWidget {
  const QuizSecondHome({super.key});

  @override
  State<QuizSecondHome> createState() => _QuizSecondHomeState();
}

class _QuizSecondHomeState extends State<QuizSecondHome> {
  late String a, b, c, d, q, img, ans, answer;
  int point = 0, questionNo = 1;
  bool acorrect = false, bcorrect = false, ccorrect = false, dcorrect = false;
  Color abgBtnColor = Colors.white;
  Color bbgBtnColor = Colors.white;
  Color cbgBtnColor = Colors.white;
  Color dbgBtnColor = Colors.white;
  bool checking = false;
  int qAttempt = 0, correctAns = 0, incorrectAns = 0;

  static const maxSeconds = 120;
  int seconds = maxSeconds;
  Timer? timer, timerNext;
  List<Model> data = [];

  @override
  void initState() {
    super.initState();
    data = Data().data;
    data.shuffle();
    questionSet();
  }

  @override
  void dispose() {
    super.dispose();
    stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('backpress');
        return false;
      },
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          elevation: 0,
          title: const Text(
            'Quiz',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                stopTimer();
                questionSet();
              },
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              showCustomDialog(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
          height: MediaQuery.of(context).size.height,
          color: Colors.black87,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Question $questionNo",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          children: [
                            TextSpan(
                                text: "/${data.length}",
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 16)),
                          ],
                        ),
                      ),
                      Text(
                        "$seconds sec",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Q$questionNo. $q",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                  ),
                ),
                img.isEmpty
                    ? Container()
                    : Center(
                        child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(height: 150, child: Image.asset(img)),
                      )),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      onTap: checking
                          ? null
                          : () {
                              checkAns("a");
                              qAttempt += 1;
                            },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: abgBtnColor,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "a) ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Expanded(
                              child: Text(
                                a,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      onTap: checking
                          ? null
                          : () {
                              checkAns("b");
                              qAttempt += 1;
                            },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: bbgBtnColor,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "b) ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Expanded(
                              child: Text(
                                b,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      onTap: checking
                          ? null
                          : () {
                              checkAns("c");
                              qAttempt += 1;
                            },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: cbgBtnColor,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "c) ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Expanded(
                              child: Text(
                                c,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      onTap: checking
                          ? null
                          : () {
                              checkAns("d");
                              qAttempt += 1;
                            },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: dbgBtnColor,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "d) ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Expanded(
                              child: Text(
                                d,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (seconds > 0) {
          if (mounted) {
            setState(() => seconds--);
          }
        } else {
          stopTimer();
          setState(() {
            if (mounted) {
              seconds = maxSeconds;
            }
          });
          questionSet();
        }
      },
    );
  }

  void stopTimer() {
    timer?.cancel();
  }

  void questionSet() {
    if (point < data.length) {
      setState(() {
        checking = false;

        q = data[point].question;
        a = data[point].a;
        b = data[point].b;
        c = data[point].c;
        d = data[point].d;
        ans = data[point].ans;
        img = data[point].img;
        answer = ans;

        seconds = maxSeconds;

        abgBtnColor = Colors.white;
        bbgBtnColor = Colors.white;
        cbgBtnColor = Colors.white;
        dbgBtnColor = Colors.white;
      });

      questionNo = point + 1;
      point += 1;
      startTimer();
    } else {
      goScoreBoard();
    }
  }

  void checkAns(String s) {
    stopTimer();
    setState(() {
      checking = true;
    });

    if (answer == s) {
      correctAns += 1;
      switch (s) {
        case "a":
          setState(() {
            abgBtnColor = Colors.greenAccent;
          });
          break;
        case "b":
          setState(() {
            bbgBtnColor = Colors.greenAccent;
          });
          break;
        case "c":
          setState(() {
            cbgBtnColor = Colors.greenAccent;
          });
          break;
        default:
          setState(() {
            dbgBtnColor = Colors.greenAccent;
          });
      }
    } else {
      incorrectAns += 1;
      switch (s) {
        case "a":
          setState(() {
            abgBtnColor = Colors.redAccent;
          });
          displayAns(answer);
          break;
        case "b":
          setState(() {
            bbgBtnColor = Colors.redAccent;
          });
          displayAns(answer);
          break;
        case "c":
          setState(() {
            cbgBtnColor = Colors.redAccent;
          });
          displayAns(answer);
          break;
        default:
          setState(() {
            dbgBtnColor = Colors.redAccent;
          });
          displayAns(answer);
      }
    }
    Timer(const Duration(seconds: 2), questionSet);
  }

  void displayAns(String answer) {
    switch (answer) {
      case "a":
        setState(() {
          abgBtnColor = Colors.greenAccent;
        });
        break;
      case "b":
        setState(() {
          bbgBtnColor = Colors.greenAccent;
        });
        break;
      case "c":
        setState(() {
          cbgBtnColor = Colors.greenAccent;
        });
        break;
      default:
        setState(() {
          dbgBtnColor = Colors.greenAccent;
        });
    }
  }

  void goScoreBoard() {
    stopTimer();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => ScoreBoard(
          score: correctAns,
          attemptedQ: qAttempt,
          totalQ: data.length,
          incorrectQ: incorrectAns,
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "You want to finished?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      goScoreBoard();
                    },
                    child: const Text('Yes'),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
