import 'package:cloud_firestore/cloud_firestore.dart';

class Fetch {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchSurveyQuestions() {
    return _firestore
        .collection('questionsCollection')
        .doc('SurveyQuestions')
        .snapshots();
  }
}
