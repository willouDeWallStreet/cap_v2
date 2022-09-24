import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cap_v2/routes.dart';
import 'package:cap_v2/screens/cap_pas_cap/player_form.dart';
import 'package:cap_v2/screens/cap_pas_cap/cap_pas_cap.dart';
import 'package:cap_v2/screens/quizz/quizz_theme_selection.dart';
import 'package:cap_v2/screens/ole_main/ole_main.dart';
import 'package:cap_v2/screens/date_game/date_game.dart';

void main() { runApp(const MyApp()); }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Games party'),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  static const routeName = '/HomePage';

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void goToGamePage(pRouteGame) {
    setState(() {
      Navigator.pushNamed(context, pRouteGame);
    });
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
              'Sélectionner un jeu',
              textScaleFactor: 2.25
            ),
            SizedBox(height: 80),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () { goToGamePage(PlayerFormPageCore.routeName); },
                child: Text(
                  'Cap ou pas cap',
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
                onPressed: () {},
                child: Text(
                  'Action ou vérité',
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
                onPressed: () {},
                child: Text(
                  'Devine les mots',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.5
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () { goToGamePage(ThemeQuizzPageCore.routeName); },
                child: Text(
                  'Quizz',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.5
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () { goToGamePage(OleMainPageCore.routeName); },
                child: Text(
                  'Olé main',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.5
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () { goToGamePage(DateGamePageCore.routeName); },
                child: Text(
                  'Jeu des dates',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.5
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



///////////////////////////////
/// CAP OU PAS CAP
///////////////////////////////
///
/// Le formulaire pour inscrire les joueurs
///
//TODO -d
/*class PlayerFormPageCore extends StatefulWidget {
  const PlayerFormPageCore({Key? key, required this.title}) : super(key: key);

  static const routeName = '/PlayerFormPageCore';
  final String title;
  
  @override
  PlayerFormPage createState()  => new PlayerFormPage();
}

class PlayerFormPage extends State<PlayerFormPageCore> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un nom';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Commencer la partie'),
            ),
          ),
        ],
      ),
    );
  }
}
*/
///
/// Le jeu
///
class CapPageCore extends StatefulWidget {

  const CapPageCore({Key? key, required this.title}) : super(key: key);

  static const routeName = '/NextPageCore';

  final String title;

  @override
  CapPasCapPage createState() => new CapPasCapPage();
}


class CapPasCapPage extends State<CapPageCore> {
  static List<String> capList = [
    "Faire 20 pompes", 
    "Faire deviner une chanson en la chantant avec de l'eau dans la bouche",
    "Concours de blagues",
    "Faire un cul sec",
    "Boire 3 gorgées",
    "Raconter ta première fois"
  ];
  String currentQuestion = "Let's gooooo !";

  void selectQuestion() {
    setState(() {
      var rng = Random();
      currentQuestion = capList[rng.nextInt(capList.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Cap ou pas cap de ...',
              style: const TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 2.5
            ),
            SizedBox(height: 35),
            Text(
              '$currentQuestion',
              style: TextStyle(fontStyle: FontStyle.italic),
              textScaleFactor: 2.0,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: selectQuestion,
        label: const Text('Next question'),
        icon: const Icon(Icons.arrow_forward),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
