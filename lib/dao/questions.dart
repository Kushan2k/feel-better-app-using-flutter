class Question {
  final String text;
  final List<Map<String, int>> answers;
  final int qID;

  Question({required this.text, required this.answers, required this.qID});

  factory Question.fromJson(Map<String, dynamic> json) {
    List<Map<String, int>> parsedAnswers = [];

    final q = json['q']['question'] ?? '';
    final int qID = json['q_no'] ?? 0;

    if (![2, 4, 10].contains(qID)) {
      final Map<String, dynamic> a = json['q']['answers'] ?? {};
      for (String key in a.keys) {
        parsedAnswers.add({key: a[key] ?? 0});
      }
    }
    print('================Answers=========: $parsedAnswers');

    // final Map<String, int> a = json['a']['answers'] ?? {};

    return Question(text: q, answers: parsedAnswers, qID: qID);
  }
}
