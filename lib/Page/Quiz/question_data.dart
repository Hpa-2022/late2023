class Question {
  late final int id, answer;
  late final String question;
  late final List<String> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options});
}

const List sample_data = [
  {
    "id": 1,
    "question": "What is your name?",
    "options": ['Hpa', 'Hpa Tunechi', 'tunechi', 'lil'],
    "answer_index": 1,
  },
  {
    "id": 2,
    "question": "What is your age?",
    "options": ['28', '20', '30', 'almost 29'],
    "answer_index": 3,
  },
  {
    "id": 3,
    "question": "Who is the best rapper alive?",
    "options": ['Hpa', 'Hpa Tunechi', 'tunechi', 'lil'],
    "answer_index": 2,
  },
];
