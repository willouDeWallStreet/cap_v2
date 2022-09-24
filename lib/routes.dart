import 'package:flutter/widgets.dart';
import 'package:cap_v2/main.dart';
import 'package:cap_v2/screens/cap_pas_cap/player_form.dart';
import 'package:cap_v2/screens/cap_pas_cap/cap_pas_cap.dart';
import 'package:cap_v2/screens/quizz/quizz.dart';
import 'package:cap_v2/screens/quizz/quizz_theme_selection.dart';
import 'package:cap_v2/screens/ole_main/ole_main.dart';
import 'package:cap_v2/screens/date_game/date_game.dart';
import 'package:cap_v2/main.dart';

final routes = <String, WidgetBuilder> {
  MyHomePage.routeName: (BuildContext context) => new MyHomePage(title: 'Games party'),
  CapPageCore.routeName: (BuildContext context) => new CapPageCore(title: 'Cap ou pas cap'),
  PlayerFormPageCore.routeName: (BuildContext context) => new PlayerFormPageCore(title: 'Cap ou pas cap'),
  ThemeQuizzPageCore.routeName: (BuildContext context) => new ThemeQuizzPageCore(title: 'Quizz'),
  QuizzPageCore.routeName: (BuildContext context) => new QuizzPageCore(title: 'Quizz'),
  OleMainPageCore.routeName: (BuildContext context) => new OleMainPageCore(title: 'Olé main'),
  DateGamePageCore.routeName: (BuildContext context) => new DateGamePageCore(title: 'Jeu des dates'),
};