import 'package:json_annotation/json_annotation.dart';
part 'Answer.g.dart';

@JsonSerializable()
class Answer {
  String answer;
  bool onGoodAnswer;

  Answer(this.answer, this.onGoodAnswer);

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}