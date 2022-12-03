import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/components/mcqs.dart';
import 'package:quiz/screens/survey.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<List<MCQ>> fetchQuestions() async {
    final List<MCQ> balerion = [];
    String json_local =
        await DefaultAssetBundle.of(context).loadString('assets/api.json');
    var qn = jsonDecode(json_local)['results'];
    for (var x in qn) {
      MCQ kek = MCQ.fromMap(x);
      balerion.add(kek);
    }
    print(balerion);
    return balerion;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MCQ>>(
      future: fetchQuestions(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Survey();
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
