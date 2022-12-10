import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PointsCountProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User _user = FirebaseAuth.instance.currentUser!;
  int skipped = 0, right = 0, notcorrect = 0;
  int get skip => skipped;
  int get correct => right;
  int get incorrect => notcorrect;

  set skip(int skipped) {}

  void nailedit() {
    right++;
    notifyListeners();
  }

  void wronged() {
    notcorrect++;
    notifyListeners();
  }

  void jumped() {
    skipped++;
    notifyListeners();
  }

  Future setQuizScore() async {
    _db.collection('QuizData').doc(_user.uid).set({
      DateTime.now().toLocal().toString(): {
        'correct': right,
        'incorrect': notcorrect,
        'skipped': skipped
      },
    }, SetOptions(merge: true));
  }
}
