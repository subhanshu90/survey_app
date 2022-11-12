import 'dart:math';

class MCQ {
  final String question;
  final int correctOption;
  final List<String> options;
  const MCQ(
      {required this.question,
      required this.correctOption,
      required this.options});

  bool validate(int selectedOption) {
    return selectedOption == correctOption;
  }

  factory MCQ.fromMap(Map qn) {
    List<String> givenOptions = qn['incorrect_answers'];
    int corr = Random().nextInt(givenOptions.length);
    givenOptions.insert(corr, qn['correct_answer']);
    return MCQ(
        question: qn['question'], correctOption: corr, options: givenOptions);
  }
}
