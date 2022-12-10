import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DataBaseProvider extends ChangeNotifier {
  final CollectionReference _questionsCollection =
      FirebaseFirestore.instance.collection('questionsCollection');
  final User _user = FirebaseAuth.instance.currentUser!;

  Future setSurveyQuestions(
      {required String question, required List<String> options}) async {
    _questionsCollection.doc('SurveyQuestions').set({
      DateTime.now().toUtc().toString(): {
        'question': question,
        'options': options
      }
    }, SetOptions(merge: true));
  }

  Future setQuizQuestion(
      {required String question,
      required List<String> options,
      required int correct}) async {
    _questionsCollection.doc('QuizQuestions').set({
      DateTime.now().toString(): {
        'correct': correct,
        'question': question,
        'options': options
      },
    }, SetOptions(merge: true));
  }

  Future setFeedbackQuestion({required String question}) async {
    _questionsCollection.doc('FeedbackQuestions').set({
      DateTime.now().toString(): {
        question,
      }
    });
  }
}
