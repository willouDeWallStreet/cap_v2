import 'package:cap_v2/model/Question.dart';
import 'package:flutter/material.dart';
import 'package:cap_v2/services/api-srv.dart' as api;
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

class DateGamePageCore extends StatefulWidget {
  const DateGamePageCore({Key? key, required this.title}) : super(key: key);

  static const routeName = '/DateGamePageCore';
  final String title;
  
  @override
  DateGamePage createState()  => DateGamePage();
}

class DateGamePage extends State<DateGamePageCore> {

  List<Question> questionAnswersList = [];
  late Question currentQuestion;
  int indexQuestionList = 0;
  List<int> indexAlreadyUsedList = [];
  bool showResponse = false;
  bool endGame = false;


  @override
  void initState() {
    super.initState();
    loadQuestionListFromApi();
  }

  Future<Question> loadQuestionListFromApi() async {
    var questionList = await rootBundle.loadString('data/date_game_list.json');
        Iterable list = json.decode(questionList);
        questionAnswersList = list.map((model) => Question.fromJson(model)).toList();        
        currentQuestion = questionAnswersList[indexQuestionList];
        if (!indexAlreadyUsedList.contains(indexQuestionList)) {
          indexAlreadyUsedList.add(indexQuestionList);
        }
        return currentQuestion;
  }

  void pickAnotherQuestion() {
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
        onPressed: pickAnotherQuestion,
        label: const Text('Next question'),
        icon: const Icon(Icons.arrow_forward),
        backgroundColor: Colors.pink,
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
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
                  SizedBox(height: 80),
                  if(!showResponse) SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: showHideResponse,
                      child: Text(
                        'Réponse',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 1.5
                      )
                    ),
                  )
                  else Center(
                    child: FutureBuilder(
                      future: loadQuestionListFromApi(), // async work
                      builder: (context, AsyncSnapshot<Question> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.answerList.where((answerObj) => answerObj.onGoodAnswer).first.answer,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 2.5,
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  ),
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
        ),
      ),
      floatingActionButton: _getFAB()
    );
  }
}