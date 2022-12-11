import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz/services/store.dart';

class PointsCountProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User _user = FirebaseAuth.instance.currentUser!;
  int _skipped = 0, _right = 0, _notcorrect = 0;
  int get skip => _skipped;
  int get correct => _right;
  int get incorrect => _notcorrect;

  set skip(int jump) {
    jump = _skipped;
  }

  set correct(int right) {
    right = _skipped;
  }

  set incorrect(int wrong) {
    wrong = _skipped;
  }

  void nailedit() {
    _right++;
    notifyListeners();
  }

  void wronged() {
    _notcorrect++;
    notifyListeners();
  }

  void jumped() {
    _skipped++;
    notifyListeners();
  }

  void restart() {
    _right = 0;
    _notcorrect = 0;
    _skipped = 0;
  }

  Future setQuizScore() async {
    _db.collection('QuizData').doc(_user.uid).set({
      uuid.v1(): {
        'correct': _right,
        'incorrect': _notcorrect,
        'skipped': _skipped
      },
    }, SetOptions(merge: true));
  }
}
