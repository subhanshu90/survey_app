import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quiz/components/mcqs.dart';
import 'package:quiz/screens/survey.dart';

import '../components/button.dart';

Map<double, String> emotes = {
  1.0: "assets/icons/1.png",
  2.0: "assets/icons/2.png",
  3.0: "assets/icons/3.png",
  4.0: "assets/icons/4.png",
  5.0: "assets/icons/5.png"
};
double skore = 0;

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackScreen> {
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            itemBuilder: (context, index) {
              if (index == que.length) {
                return Container(
                  child: Text("${skore / que.length}"),
                );
              }
              return ReviewItems(
                ques: que.elementAt(index),
                controller: _controller,
              );
            }));
  }
}

class ReviewItems extends StatefulWidget {
  final MCQ ques;
  final PageController controller;
  ReviewItems({super.key, required this.ques, required this.controller});

  @override
  State<ReviewItems> createState() => _ReviewItemsState();
}

class _ReviewItemsState extends State<ReviewItems> {
  double rating = 3.0;

  void changeEmote(double rate) {
    setState(() {
      rating = rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.ques.question,
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 50,
          ),
          Image.asset(emotes[rating]!),
          const SizedBox(
            height: 75,
          ),
          RatingBar.builder(
              initialRating: 3.0,
              minRating: 1,
              maxRating: 5,
              allowHalfRating: false,
              itemPadding: const EdgeInsets.symmetric(horizontal: 5),
              itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber[800],
                  ),
              onRatingUpdate: (rate) {
                rating = rate;
                changeEmote(rate);
              }),
          const SizedBox(
            height: 50,
          ),
          BigButtonWithIcon(
            onPressed: () {
              skore += rating;
              widget.controller.nextPage(
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            },
            buttonIcon: const Icon(Icons.navigate_next),
            buttonLable: const Text("Next"),
          )
        ],
      ),
    );
  }
}
