import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/components/mcqs.dart';
import 'package:quiz/components/piechart.dart';
import 'package:quiz/services/fetch.dart';
import 'package:quiz/services/points.dart';
import '../components/questions.dart';

class Survey extends StatelessWidget {
  const Survey({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  Provider.of<PointsCountProvider>(context).jumped();
                  controller.nextPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOut,
                  );
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
              List<MCQ> que =
                  jsonQuestions.values.map((e) => MCQ.fromMap(e)).toList();
              print(que);
              return PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                itemBuilder: (context, index) {
                  print(index);
                  if (index == que.length) {
                    return const Result();
                  }
                  return Questions(
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
