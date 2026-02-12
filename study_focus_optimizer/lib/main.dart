import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const StudyFocusApp());
}

class StudyFocusApp extends StatelessWidget {
  const StudyFocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Study Focus Optimizer",
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int focusSeconds = 25 * 60;
  int breakSeconds = 5 * 60;

  int timeLeft = 25 * 60;
  int sessions = 0;

  bool isRunning = false;
  bool isBreak = false;

  Timer? timer;

  final quotes = [
    "Stay focused 🚀",
    "One step at a time",
    "Consistency wins",
    "You got this 💪",
    "Discipline > Motivation"
  ];

  String get randomQuote => quotes[Random().nextInt(quotes.length)];

  String get timeText {
    int m = timeLeft ~/ 60;
    int s = timeLeft % 60;
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  double get progress {
    int total = isBreak ? breakSeconds : focusSeconds;
    return 1 - (timeLeft / total);
  }

  void startPause() {
    if (isRunning) {
      timer?.cancel();
      setState(() => isRunning = false);
      return;
    }

    isRunning = true;

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (timeLeft == 0) {
        timer?.cancel();

        setState(() {
          if (!isBreak) {
            sessions++;
            isBreak = true;
            timeLeft = breakSeconds;
          } else {
            isBreak = false;
            timeLeft = focusSeconds;
          }
          isRunning = false;
        });
      } else {
        setState(() => timeLeft--);
      }
    });
  }

  void reset() {
    timer?.cancel();
    setState(() {
      isRunning = false;
      isBreak = false;
      timeLeft = focusSeconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff667eea), Color(0xff764ba2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),

                /// Title
                const Text(
                  "Study Focus Optimizer",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                /// Quote Card
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      randomQuote,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                /// Circular Timer
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 10,
                        backgroundColor: Colors.white24,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      timeText,
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// Status
                Text(
                  isBreak ? "Break Time ☕" : "Focus Time 📚",
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),

                Text(
                  "Sessions completed: $sessions",
                  style: const TextStyle(color: Colors.white70),
                ),

                const Spacer(),

                /// Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: startPause,
                        child: Text(isRunning ? "Pause" : "Start"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: reset,
                        child: const Text("Reset"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
