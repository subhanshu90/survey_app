import 'package:flutter/material.dart';

class PointsCountProvider extends ChangeNotifier {
  int _skipped = 0, _correct = 0, _incorrect = 0;
  int get skip => _skipped;
  int get correct => _correct;
  int get incorrect => _incorrect;

  void right() {
    _correct++;
    notifyListeners();
  }

  void wrong() {
    _incorrect++;
    notifyListeners();
  }

  void jumped() {
    _skipped++;
    notifyListeners();
  }
}
