import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:sensors/sensors.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:math';

class OleMainPageCore extends StatefulWidget {
  const OleMainPageCore({Key? key, required this.title}) : super(key: key);

  static const routeName = '/OleMainPageCore';
  final String title;

  @override
  OleMainPage createState()  => OleMainPage();
}

class OleMainPage extends State<OleMainPageCore> {
  double gyroX = 0;
  double gyroY = 0;
  double gyroYBoosted = 0;
  double gyroZ = 0;
  double amZ = 0;
  double amZBoosted = 0;
  int counter = 0;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  int currentIndexOleList = 0;
  String currentOle = "";
  List<String> oleList = [];
  List<int> indexAlreadyUsedList = [];
  bool endGame = false;
  int goodResponseNb = 0;
  int badResponseNb = 0;

  @override
  void initState() {
    super.initState();
    loadOleListFromApi();
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        gyroX = ((event.x * 100).round() / 100).clamp(-1.0, 1.0) * -1;
        gyroY = ((event.y * 100).round() / 100).clamp(-1.0, 1.0);
        gyroZ = ((event.z * 100).round() / 100).clamp(-1.0, 1.0);
      });
    });
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        amZ = event.z;
        gyroYBoosted = gyroY * 10;
        amZBoosted = amZ * 10;
        //counter = (counter<10) ? counter+1 : 0;
        print('---> BEFORE 5sec we can\'t play Counter: $counter');
        if (counter>10) {
          print('Counter: $counter');
          print('amZ: $amZ');

          amZBoosted = (counter<10) ? (amZBoosted + amZ * counter * gyroYBoosted) : (amZ * counter);
          print('amZBoosted: $amZBoosted');
          print('gyroYBoosted: $gyroYBoosted');
          if (amZBoosted > 50) {
            counter = 0;
            print('\n\n\n');
            print('IT IS A WIIIIIIIN ! ! ! ! ! !');
            goodResponseNb++;
            print('-------------> goodResponseNb: $goodResponseNb');
            pickAnotherRandomQuestion();
            print('\n\n\n');
          } else if (amZBoosted < -40) {
            counter = 0;
            print('\n\n\n');
            print('IT IS A LOOOOOOOOSE ! ! ! ! ! !');
            badResponseNb++;
            print('----> badResponseNb: $badResponseNb');
            pickAnotherRandomQuestion();
            print('\n\n\n');
          }
        } else {
          counter++;
        }
      });
    });
  }

  //TODO WEV -v2 (2022-09-27-0:35): créé un objet avec libelle, thème et difficulté
  Future<String> loadOleListFromApi() async {
    var oleListJon = await rootBundle.loadString("data/ole_main_people.json");
    oleList = json.decode(oleListJon).cast<String>();
    debugPrint('oleList: $oleList');
    currentOle = oleList[currentIndexOleList];
    if (!indexAlreadyUsedList.contains(currentIndexOleList)) {
      indexAlreadyUsedList.add(currentIndexOleList);
    }
    debugPrint('indexAlreadyUsedList: $indexAlreadyUsedList');
    return currentOle;
  }

  void pickAnotherRandomQuestion() {
    setState(() {
      print('\n\n\n');
      var rng = Random();
      //TODO WEV -i (2022-09-26-23:18): improvement: indexAlreadyUsedList -> indexNotAlreadyUsedList et on pick un random index dans cette liste
      while (indexAlreadyUsedList.contains(currentIndexOleList) && oleList.length > indexAlreadyUsedList.length) {
        currentIndexOleList = rng.nextInt(oleList.length);
      }
      print('currentIndexOleList : $currentIndexOleList');
      print('oleList : $oleList');
      print('indexAlreadyUsedList : $indexAlreadyUsedList');

      if (oleList.length == indexAlreadyUsedList.length) {
        endGame = true;
      } else {
        currentOle = oleList[currentIndexOleList];
        print('currentIndexOleList: $currentIndexOleList');
        var size = oleList.length;
        print('oleListSize: $size');
        var sizeIndexAlreadyUsed = indexAlreadyUsedList.length;
        print('sizeIndexAlreadyUsed: $sizeIndexAlreadyUsed');
        print('indexAlreadyUsedList: $indexAlreadyUsedList');
        var textToDisplay = indexAlreadyUsedList.join(',');
        print('textToDisplay: $textToDisplay');
        print('\n\n\n');
      }
    });
  }

  void onEnd() { print('onEnd'); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Here you can set what ever background color you need.
      backgroundColor: Colors.pink,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          height: 600,
          width: 400,
          child: Row(children: [
            Transform.translate(
              offset: Offset(gyroY, 0),
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Text("X: ${gyroX}"), Text("Y: ${gyroY}"), Text("Z: ${gyroZ}"),
                      Text("\n\n\n"),
                      /*Text("amZ: ${amZ}"),*/
                      RotatedBox(quarterTurns: 1, child: Text("amZ: ${amZ}", textScaleFactor: 2.25)),
                      ],
                  ),
                ),
              ),
            ),
            Center(
              child: RotatedBox(quarterTurns: 1, child:
                CountdownTimer(
                  onEnd: onEnd,
                  endTime: endTime,
                ),
              ),
            ),
            Center(
              child: RotatedBox(quarterTurns: 1, child:
                FutureBuilder(
                  future: loadOleListFromApi(), // async work
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    return Text(snapshot.data!, textScaleFactor: 2.0, textAlign: TextAlign.center);
                  },
                )
              )
            ),
          ],
        )
      ),
    );
  }
}
