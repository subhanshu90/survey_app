import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/components/mcqs.dart';
import 'package:quiz/components/piechart.dart';
import 'package:quiz/services/fetch.dart';
import 'package:quiz/services/points.dart';
import '../components/questions.dart';

class Quizz extends StatefulWidget {
  const Quizz({super.key});

  @override
  State<Quizz> createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {
  @override
  void initState() {
    super.initState();
    Provider.of<PointsCountProvider>(context, listen: false).incorrect = 0;
    Provider.of<PointsCountProvider>(context, listen: false).skip = 0;
    Provider.of<PointsCountProvider>(context, listen: false).correct = 0;
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: Fetch().fetchQuizQuestons(),
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
            List<MCQ> que =
                jsonQuestions.values.map((e) => MCQ.fromMap(e)).toList();

            return PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              itemBuilder: (context, index) {
                if (index == que.length) {
                  Provider.of<PointsCountProvider>(context, listen: false)
                      .setQuizScore();
                  return const Result();
                }
                return Questions(
                  qn: que.elementAt(index),
                  controller: controller,
                );
              },
            );
          }),
    );
  }
}
