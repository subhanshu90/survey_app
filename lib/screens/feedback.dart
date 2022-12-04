import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PageView.builder(itemBuilder: (context, index) {
      return ReviewItems();
    }));
  }
}

class ReviewItems extends StatefulWidget {
  const ReviewItems({super.key});

  @override
  State<ReviewItems> createState() => _ReviewItemsState();
}

class _ReviewItemsState extends State<ReviewItems> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(
            "give feedback on ?",
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: 50,
          ),
          RatingBar.builder(
              itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber[800],
                  ),
              onRatingUpdate: (fsdf) {}),
        ],
      ),
    );
  }
}
