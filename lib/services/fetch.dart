import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Fetch {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream fetchSurveyQuestions() {
    return firestore
        .collection('questionsCollection')
        .doc('surveyQuestions')
        .snapshots();
  }
}
