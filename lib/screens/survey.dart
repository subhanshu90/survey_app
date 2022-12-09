import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/mcqs.dart';
import 'package:quiz/components/piechart.dart';
import 'package:quiz/services/fetch.dart';
import '../components/questions.dart';

const List<String> options = [
  'semiconductors',
  'conductors',
  'insulators',
  'superconductors'
];

const MCQ qn1 = MCQ(
    question: 'what are processors made up of ?',
    correctOption: 0,
    options: options);

const MCQ qn2 = MCQ(
    question: 'what type of material is wood',
    correctOption: 2,
    options: options);

const MCQ qn3 = MCQ(
    question: 'what are wires made up of ?',
    correctOption: 1,
    options: options);

class Survey extends StatefulWidget {
  const Survey({super.key});

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  final PageController controller = PageController();
  int correct = 0;
  int incorrect = 0;
  int skip = 0;
  void right() {
    setState(() {
      correct = ++correct;
    });
  }

  void wrong() {
    setState(() {
      incorrect = ++incorrect;
    });
  }

  void skiped() {
    setState(() {
      skip = ++skip;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  skiped();
                  controller.nextPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOut);
                },
                child: const Text("skip"))
          ],
        ),
        body: StreamBuilder(
            stream: Fetch().fetchSurveyQuestions(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: LinearProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: Image.asset("assets/icons/1.png"),
                );
              }
              Map<String, dynamic> jsonQuestions =
                  snapshot.data!.data() as Map<String, dynamic>;
              print(jsonQuestions.length);
              List<MCQ> que = jsonQuestions.values
                  .map((e) => MCQ.fromMap(e.cast()))
                  .toList();
              return PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                itemCount: jsonQuestions.length,
                itemBuilder: (context, index) {
                  if (index == jsonQuestions.length) {
                    return Result(
                      correct: correct,
                      incorrect: incorrect,
                      skip: skip,
                    );
                  }
                  return Questions(
                    qn: que.elementAt(index),
                    right: right,
                    wrong: wrong,
                    controller: controller,
                  );
                },
              );
            }),
      ),
    );
  }
}
