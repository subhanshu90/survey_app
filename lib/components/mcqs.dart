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
    List<dynamic> op = qn['options'];
    List<String> option = op.cast<String>();
    return MCQ(
      question: qn['question'],
      correctOption: qn['correct'],
      options: option,
    );
  }
}
