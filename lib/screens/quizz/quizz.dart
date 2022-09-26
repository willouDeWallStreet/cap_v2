import 'package:cap_v2/model/Answer.dart';
import 'package:cap_v2/model/Question.dart';
import 'package:cap_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:cap_v2/services/api-srv.dart' as api;
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

class QuizzPageCore extends StatefulWidget {
  const QuizzPageCore({Key? key, required this.title}) : super(key: key);

  static const routeName = '/QuizzPageCore';
  final String title;

  @override
  QuizzPage createState()  => QuizzPage();
}

class QuizzPage extends State<QuizzPageCore> {

  List<Question> questionAnswersList = [];
  late Question currentQuestion;
  int indexQuestionList = 0;
  int themeId = 0;
  List<int> indexAlreadyUsedList = [];
  bool showResponse = false;
  bool endGame = false;
  String resultText = "";
  bool hasGoodResponse = false;
  String goodResultText = "";

  @override
  void initState() {
    super.initState();
    loadQuestionListFromApi();
  }

  Future<Question> loadQuestionListFromApi() async {
    var questionList = await rootBundle.loadString(getJsonFileNameByThemeId());
        Iterable list = json.decode(questionList);
        questionAnswersList = list.map((model) => Question.fromJson(model)).toList();
        currentQuestion = questionAnswersList[indexQuestionList];
        if (!indexAlreadyUsedList.contains(indexQuestionList)) {
          indexAlreadyUsedList.add(indexQuestionList);
        }
        debugPrint('indexAlreadyUsedList: $indexAlreadyUsedList');
        return currentQuestion;
  }

  String getJsonFileNameByThemeId() {
    debugPrint('from getJsonFileNameByThemeId --> themeId: $themeId');
    switch (themeId) {
      case 1: {
        return 'data/quizz_sport_list.json';
      }
      case 2: {
        return 'data/quizz_cinema_list.json';
      }
      default: {
        return 'data/quizz_alcool_list.json';
      }
    }
  }

  void pickAnotherRandomQuestion() {
    setState(() {
      var rng = Random();
      while (indexAlreadyUsedList.contains(indexQuestionList) && questionAnswersList.length > indexAlreadyUsedList.length) {
        indexQuestionList = rng.nextInt(questionAnswersList.length);
      }

      if (questionAnswersList.length == indexAlreadyUsedList.length) {
        endGame = true;
      } else {
        currentQuestion = questionAnswersList[indexQuestionList];
        showResponse = false;
        debugPrint('indexQuestionList: $indexQuestionList');
        var test = currentQuestion.question;
        debugPrint('questionTitle: $test');
        debugPrint('themeId: $themeId');
        var size = questionAnswersList.length;
        debugPrint('questionAnswersListSize: $size');
        var sizeIndexAlreadyUsed = indexAlreadyUsedList.length;
        debugPrint('sizeIndexAlreadyUsed: $sizeIndexAlreadyUsed');
        debugPrint('indexAlreadyUsedList: $indexAlreadyUsedList');
        var textToDisplay = indexAlreadyUsedList.join(',');
        debugPrint('textToDisplay: $textToDisplay');
      }
    });
  }

  void showHideResponse() { setState(() { showResponse = !showResponse; }); }

  void backToHomePage() {
    setState(() {
      Navigator.pop(context, true);
    });
  }

  Widget _getFAB() {
    if (endGame) {
      return Container();
    } else {
      return FloatingActionButton.extended(
        onPressed: pickAnotherRandomQuestion,
        label: const Text('Next question'),
        icon: const Icon(Icons.arrow_forward),
        backgroundColor: Colors.pink,
      );
    }
  }

  void checkResponse(Question pQuestion, int pIndexResponse) {
    setState(() {
      hasGoodResponse = pQuestion.answerList[pIndexResponse].onGoodAnswer;
      resultText = hasGoodResponse ? "Bonne réponse" : "Mauvaise réponse";
      if (!hasGoodResponse) {
        goodResultText = "La bonne réponse était:\n" + pQuestion.answerList.where((answerObj) => answerObj.onGoodAnswer).first.answer;
      }
      showResponse = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    themeId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if(!endGame) Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: FutureBuilder(
                      future: loadQuestionListFromApi(), // async work
                      builder: (context, AsyncSnapshot<Question> snapshot) {
                          return Text(snapshot.data!.question, textScaleFactor: 2.0, textAlign: TextAlign.center);
                        },
                      )
                  ),
                  SizedBox(height: 50),
                  if(!showResponse) Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ListTile(
                          title: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 5.0),
                                  child: FutureBuilder(
                                    future: loadQuestionListFromApi(), // async work
                                    builder: (context, AsyncSnapshot<Question> snapshot) {
                                      return ElevatedButton(
                                        onPressed: () { checkResponse(snapshot.data!, 0); },
                                        child: Text(
                                          snapshot.data!.answerList[0].answer,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                          textScaleFactor: 1.5,
                                          textAlign: TextAlign.center,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(100, 125),
                                          primary: Colors.blue
                                        ),
                                      );
                                    }
                                  )
                                )
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 5.0),
                                  child: FutureBuilder(
                                    future: loadQuestionListFromApi(), // async work
                                    builder: (context, AsyncSnapshot<Question> snapshot) {
                                      return ElevatedButton(
                                        onPressed: () { checkResponse(snapshot.data!, 1); },
                                        child: Text(
                                          snapshot.data!.answerList[1].answer,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                          textScaleFactor: 1.5,
                                          textAlign: TextAlign.center,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(100, 125),
                                          primary: Colors.red
                                        ),
                                      );
                                    }
                                  )
                                )
                              ),
                            ],
                          ),
                        ),

                        ListTile(
                          title: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 5.0),
                                  child: FutureBuilder(
                                    future: loadQuestionListFromApi(), // async work
                                    builder: (context, AsyncSnapshot<Question> snapshot) {
                                      return ElevatedButton(
                                        onPressed: () { checkResponse(snapshot.data!, 2); },
                                        child: Text(
                                          snapshot.data!.answerList[2].answer,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                          textScaleFactor: 1.5,
                                          textAlign: TextAlign.center,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(100, 125),
                                          primary: Colors.green
                                        ),
                                      );
                                    },
                                  )
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 5.0),
                                  child: FutureBuilder(
                                    future: loadQuestionListFromApi(), // async work
                                    builder: (context, AsyncSnapshot<Question> snapshot) {
                                      return ElevatedButton(
                                        onPressed: () { checkResponse(snapshot.data!, 3); },
                                        child: Text(
                                          snapshot.data!.answerList[3].answer,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                          textScaleFactor: 1.5,
                                          textAlign: TextAlign.center,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(100, 125),
                                          primary: Colors.purple
                                        ),
                                      );
                                    },
                                  )
                                )
                              )
                            ]
                          ),
                        ),
                      ]
                    )
                  )
                  else  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        resultText,
                        style: TextStyle(fontWeight: FontWeight.bold, color: hasGoodResponse ? Colors.green : Colors.red),
                        textScaleFactor: 2.5,
                        textAlign: TextAlign.center,
                      ),
                      if(!hasGoodResponse) Text(
                        goodResultText,
                        style: const TextStyle(fontStyle: FontStyle.italic),
                        textScaleFactor: 1.5,
                        textAlign: TextAlign.center,
                      )
                    ]
                  )
                ]
              )
            )
            else Container(
              margin: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: const Text("Fin du jeu", style: const TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 2.5, textAlign: TextAlign.center)
                  ),
                  SizedBox(height: 80),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: backToHomePage,
                      child: Text(
                        'Retour',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 1.5
                      ),
                      style: ElevatedButton.styleFrom( primary: Colors.grey ),
                    ),
                  )
                ]
              )
            ),
          ]
        )
      ),
      floatingActionButton: _getFAB()
    );
  }
}
