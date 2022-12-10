import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/components/mcqs.dart';
import 'package:quiz/components/piechart.dart';
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
        body: StreamBuilder<DocumentSnapshot>(
            stream: Fetch().surveyQuestions(),
            builder: (context, snapshot) {
              return PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                itemBuilder: (context, index) {
                  if (snapshot.hasData) print(snapshot);

                  if (index == que.length) {
                    return Result(
                        correct: correct, incorrect: incorrect, skip: skip);
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
