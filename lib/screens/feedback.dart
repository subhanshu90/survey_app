import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/components/mcqs.dart';

import 'package:quiz/screens/home.dart';
import 'package:quiz/services/fetch.dart';

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
        body: StreamBuilder(
            stream: Fetch().feedbackQuestions(),
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
              List<String> que = jsonQuestions.values
                  .map((e) => e['question'].toString())
                  .toList();
              return PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _controller,
                  itemBuilder: (context, index) {
                    if (index == que.length) {
                      return ThankYou(context, "feedback");
                    }
                    return ReviewItems(
                      question: que.elementAt(index),
                      controller: _controller,
                    );
                  });
            }));
  }
}

// ignore: non_constant_identifier_names
Widget ThankYou(BuildContext context, String bruh) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset("assets/icons/5.png"),
      const SizedBox(
        height: 50,
      ),
      Text(
        "Thank You!",
        style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        "We appreciate your $bruh!",
        style: GoogleFonts.poppins(
          fontSize: 18,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: ((context) => Home())),
                (route) => false);
          },
          child: const Text(
            "Go To Home",
            style: TextStyle(fontSize: 18),
          ))
    ],
  );
}

class ReviewItems extends StatefulWidget {
  final String question;
  final PageController controller;
  const ReviewItems(
      {super.key, required this.question, required this.controller});

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
            widget.question,
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
