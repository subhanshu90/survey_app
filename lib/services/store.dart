import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class DataBaseProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _questionsCollection =
      FirebaseFirestore.instance.collection('questionsCollection');
  final User _user = FirebaseAuth.instance.currentUser!;
  final List<Object> _surveyans = [];

  void addAns(String ans, String ques) {
    _surveyans.add({"Question": ques, "answer": ans});
  }

  final List<Object> _feedbackans = [];

  void feedbaccAdd(double star, String ques) {
    _feedbackans.add({"Question": ques, "star": star});
  }

  Future setSurveyQuestions({required String question}) async {
    _questionsCollection.doc('SurveyQuestions').set({
      uuid.v1(): {'question': question}
    }, SetOptions(merge: true));
  }

  Future setQuizQuestion(
      {required String question,
      required List<String> options,
      required int correct}) async {
    _questionsCollection.doc('QuizQuestions').set({
      uuid.v1(): {'correct': correct, 'question': question, 'options': options},
    }, SetOptions(merge: true));
  }

  Future setFeedbackQuestion({required String question}) async {
    _questionsCollection.doc('FeedbackQuestions').set({
      uuid.v1(): {'question': question}
    }, SetOptions(merge: true));
  }

  Future delQuizQuestion({
    required String timestamp,
  }) async {
    final docref = _questionsCollection.doc('QuizQuestions');
    final updates = <String, dynamic>{
      timestamp: FieldValue.delete(),
    };
    docref.update(updates);
  }

  Future delFeedbaccQuestion({
    required String timestamp,
  }) async {
    final docref = _questionsCollection.doc('FeedbackQuestions');
    final updates = <String, dynamic>{
      timestamp: FieldValue.delete(),
    };
    docref.update(updates);
  }

  Future delSurveyQuestion({
    required String timestamp,
  }) async {
    final docref = _questionsCollection.doc('SurveyQuestions');
    final updates = <String, dynamic>{
      timestamp: FieldValue.delete(),
    };
    docref.update(updates);
  }

  Future setSurveyAns() async {
    _db.collection('SurveyData').doc(_user.uid).set({
      uuid.v1(): _surveyans,
    }, SetOptions(merge: true));
  }

  Future setFeedbackAns() async {
    _db.collection('FeedbackData').doc(_user.uid).set({
      uuid.v1(): _feedbackans,
    }, SetOptions(merge: true));
  }
}
