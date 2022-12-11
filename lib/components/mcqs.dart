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

class MCQ2 {
  final String question;

  const MCQ2({
    required this.question,
  });

  factory MCQ2.fromMap(Map qn) {
    return MCQ2(question: qn['question']);
  }
}

// class QUET {
//   final String question;
//   final String timestmp;

//   const QUET({required this.question, required this.timestmp});

//   factory QUET.fromMap(Map qn) {
//     return QUET(timestmp: qn.keys.first, question: qn.values['question']);
//   }
// }
