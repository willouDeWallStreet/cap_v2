import 'package:cap_v2/model/Question.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<String> getQuestionListFuture() async {
  var questionList = await rootBundle.loadString('data/quizz_cinema_list.json');
  return questionList;
}