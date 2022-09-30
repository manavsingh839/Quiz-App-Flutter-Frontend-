
class Ques_Model {
  late int id;
  final String question;
  final String option_a;
  final String option_b;
  final String option_c;
  final String option_d;
  final String correct_answer;
  final String language;
  final String type;

  Ques_Model({
    required this.id,
    required this.question,
    required this.option_a,
    required this.option_b,
    required this.option_c,
    required this.option_d,
    required this.correct_answer,
    required this.language,
    required this.type
});

  Ques_Model.fromJson(Map<dynamic,dynamic> json):
    this.id = json['id'],
    this.question = json['question'],
    this.option_a = json['option_a'],
    this.option_b = json['option_b'],
    this.option_c = json['option_c'],
    this.option_d = json['option_d'],
    this.correct_answer = json['correct_answer'],
    this.language = json['language'],
    this.type = json['type'];
  

}