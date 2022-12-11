import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/components/mcqs.dart';
import 'package:quiz/services/fetch.dart';
import 'package:quiz/services/store.dart';
import '../components/questions.dart';
import '../services/points.dart';
import 'feedback.dart';

class Survey extends StatelessWidget {
  const Survey({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: StreamBuilder(
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
              List<MCQ2> que =
                  jsonQuestions.values.map((e) => MCQ2.fromMap(e)).toList();
              return PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                itemBuilder: (context, index) {
                  if (index == que.length) {
                    Provider.of<DataBaseProvider>(context, listen: false)
                        .setSurveyAns();
                    return ThankYou(context, "");
                  }
                  return Questions2(
                    qn: que.elementAt(index),
                    controller: controller,
                  );
                },
              );
            }),
      ),
    );
  }
}
