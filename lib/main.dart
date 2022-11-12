import 'package:flutter/material.dart';
import 'package:quiz/components/piechart.dart';
import 'package:quiz/screens/load.dart';
import 'package:quiz/screens/survey.dart';
import 'screens/home.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: Colors.deepPurple[200], useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
