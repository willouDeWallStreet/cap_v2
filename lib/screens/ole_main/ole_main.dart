import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

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

  @override
  void initState() {
    super.initState();
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
        counter = (counter<10) ? counter+1 : 0;
        print('Counter: $counter');
        print('amZ: $amZ');
        
        amZBoosted = (counter<10) ? (amZBoosted + amZ * counter * gyroYBoosted) : (amZ * counter);
        print('amZBoosted: $amZBoosted');
        print('gyroYBoosted: $gyroYBoosted');
        if (amZBoosted > 130) {
          counter = 0;
          print('\n\n\n');
          print('IT IS A WIIIIIIIN ! ! ! ! ! !');
          print('\n\n\n');
        } else if (amZBoosted < -80) {
          counter = 0;
          print('\n\n\n');
          print('IT IS A LOOOOOOOOSE ! ! ! ! ! !');
          print('\n\n\n');
        }
      });
    });
  }
  
  void onEnd() { print('onEnd'); }

  @override
  Widget build(BuildContext context) {        
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          height: 100,
          width: 100,
          child: Row(children: [
            Transform.translate(
              offset: Offset(gyroY, 0),
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Text("X: ${gyroX}"), Text("Y: ${gyroY}"), Text("Z: ${gyroZ}"),
                      Text("Z: ${amZ}"),
                      ],
                  ),
                ),
              ),
            ),
            Center(
              child: CountdownTimer(
                onEnd: onEnd,
                endTime: endTime,
              ),
            ),
          ],
        )
      ),
    );
  }
}