import 'package:cloud_firestore/cloud_firestore.dart';

class Fetch {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchSurveyQuestions() {
    return firestore
        .collection('questionsCollection')
        .doc('SurveyQuestions')
        .snapshots();
  }
}
