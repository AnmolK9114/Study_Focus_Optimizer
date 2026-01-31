import 'package:flutter/material.dart';

void main() {
  runApp(const StudyFocusApp());
}

class StudyFocusApp extends StatelessWidget {
  const StudyFocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Focus Optimizer',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Study Focus Optimizer'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Start Study Session'),
          ),
        ),
      ),
    );
  }
}
