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
    http.Response response = await http
        .get(Uri.parse('https://opentdb.com/api.php?amount=10&type=multiple'));
    jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<Map> qn = jsonDecode(response.body)['results'];
      var x = qn.map((e) => MCQ.fromMap(e)).toList();
      print(x);
      return x;
    } else {
      throw Exception('Failed to load album');
    }
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
        return const CircularProgressIndicator();
      },
    );
  }
}
