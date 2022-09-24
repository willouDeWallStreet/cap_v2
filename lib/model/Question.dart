import 'package:cap_v2/model/Answer.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Question.g.dart';

@JsonSerializable()
class Question {
  String question;
  List<Answer> answerList;

  Question(this.question, this.answerList);

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}