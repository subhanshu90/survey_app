import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz/constants/constants.dart';
import 'package:quiz/services/points.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../screens/home.dart';

class Result extends StatelessWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    final int correct = Provider.of<PointsCountProvider>(context).correct;
    final int incorrect = Provider.of<PointsCountProvider>(context).incorrect;
    final int skip = Provider.of<PointsCountProvider>(context).skip;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text.rich(
            TextSpan(
                text: "Your Score is ",
                style: GoogleFonts.poppins(
                    textStyle: text(29, FontWeight.bold, Colors.black)),
                children: [
                  TextSpan(
                      text: '${correct - incorrect}',
                      style: GoogleFonts.poppins(
                          textStyle: text(30, FontWeight.w700, Colors.blue)))
                ]),
          ),
          const SizedBox(
            height: 100,
          ),
          Chart(correct: correct, incorrect: incorrect, skip: skip),
          SizedBox(
            height: 100,
          ),
          TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: ((context) => Home())),
                    (route) => false);
              },
              child: const Text(
                "Go To Home",
                style: TextStyle(fontSize: 18),
              ))
        ],
      ),
    );
  }
}

class Chart extends StatelessWidget {
  final int correct, incorrect, skip;
  const Chart(
      {super.key,
      required this.correct,
      required this.incorrect,
      required this.skip});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> bruh = [
      ChartData('correct', correct),
      ChartData('incorrect', incorrect),
      ChartData('skip', skip)
    ];
    return Center(
      child: SfCircularChart(series: <CircularSeries>[
        PieSeries<ChartData, String>(
            dataSource: bruh,
            xValueMapper: (ChartData bruh, _) => bruh.x,
            yValueMapper: (ChartData bruh, _) => bruh.y,
            dataLabelMapper: (ChartData bruh, _) => bruh.x,
            explode: true,
            explodeAll: false,
            dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelPosition: ChartDataLabelPosition.outside,
                useSeriesColor: true,
                showZeroValue: false)),
      ]),
    );
  }
}

class ChartData {
  ChartData(
    this.x,
    this.y,
  );
  final String x;
  final int y;
}
