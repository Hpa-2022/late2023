import 'dart:async';

import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const maxSeconds = 10;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        stopTimer();
        setState(() {
          seconds = maxSeconds;
        });
        startTimer();
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer Testing'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    // Minus dah chuan a let zawngin a kal ang.
                    value: 1 - seconds / maxSeconds,
                    valueColor: const AlwaysStoppedAnimation(Colors.black),
                    strokeWidth: 12,
                    backgroundColor: Colors.greenAccent,
                  ),
                  Center(
                    child: Text(
                      '$seconds sec',
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '$seconds sec',
              style: const TextStyle(fontSize: 40),
            ),
            ElevatedButton(
              onPressed: () {
                startTimer();
              },
              child: const Text('Start'),
            ),
            ElevatedButton(
              onPressed: () {
                final isRunning = timer == null ? false : timer!.isActive;
                if (isRunning) {
                  stopTimer();
                }
              },
              child: const Text('Pause'),
            ),
            ElevatedButton(
              onPressed: () {
                final isRunning = timer == null ? false : timer!.isActive;
                if (isRunning) {
                  timer?.cancel();
                  setState(() {
                    seconds = maxSeconds;
                  });
                } else {
                  setState(() {
                    seconds = maxSeconds;
                  });
                }
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
