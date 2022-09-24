import 'package:cap_v2/model/Question.dart';
import 'package:cap_v2/screens/quizz/quizz.dart';
import 'package:flutter/material.dart';
import 'package:cap_v2/utils/constants.dart' as Constants;

class ThemeQuizzPageCore extends StatefulWidget {
  const ThemeQuizzPageCore({Key? key, required this.title}) : super(key: key);

  static const routeName = '/ThemeQuizzPageCore';
  final String title;
  
  @override
  ThemeQuizzPage createState()  => ThemeQuizzPage();
}

class ThemeQuizzPage extends State<ThemeQuizzPageCore> {

  void startQuizzGame(int pQuizzTheme) {
    setState(() {
      Navigator.pushNamed(context, QuizzPageCore.routeName, arguments: pQuizzTheme);
    });
  }

  @override
  void initState() {
    super.initState();
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
            Text(
              'Sélectionner un thème',
              textScaleFactor: 2.25
            ),
            SizedBox(height: 80),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  startQuizzGame(Constants.QUIZZ_THEME_SPORT);
                },
                child: Text(
                  'Sport',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.5
                )
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  startQuizzGame(Constants.QUIZZ_THEME_CINEMA);
                },
                child: Text(
                  'Cinéma',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.5
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  startQuizzGame(Constants.QUIZZ_THEME_ALCOOL);
                },
                child: Text(
                  'Alcool',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.5
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green
                ),
              ),
            ),
          ]
        ),
      )
    );
  }
}