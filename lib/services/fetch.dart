import 'package:cloud_firestore/cloud_firestore.dart';

class Fetch {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchSurveyQuestions() {
    return _firestore
        .collection('questionsCollection')
        .doc('SurveyQuestions')
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchQuizQuestons() {
    return _firestore
        .collection('questionsCollection')
        .doc('QuizQuestions')
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> feedbackQuestions() {
    return _firestore
        .collection('questionsCollection')
        .doc('FeedbackQuestions')
        .snapshots();
  }
}
