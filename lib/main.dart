import 'package:flutter/material.dart';

import 'Mediator.dart';
import 'impl/RestUserWs.dart';
import 'impl/RestWorktimeWs.dart';
import 'server/worktimews/Worktime.dart';
import 'view/DashboardView.dart';
import 'view/GatheringAlert.dart';
import 'view/LoginView.dart';
import 'view/OspiteView.dart';
import 'view/RegistraAccessoView.dart';
import 'view/RegistroAttivitaView.dart';
import 'view/SegnalazioneView.dart';
import 'view/SplashScreen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // 10.0.2.2 localhost alias for ADV
  final String localhost = '10.0.2.2';
  final Mediator mediator = Mediator();
  var restUserWs = RestUserWs('http://$localhost:3000');
  mediator.setUserWs(restUserWs);
  var restWorktimeWs = RestWorktimeWs('http://$localhost:8080');
  mediator.setWorktimeWs(restWorktimeWs);
  // var restGatheringWs = RestGatheringWs('http://10.0.2.2:8081');
  // mediator.setGatheringWs(restGatheringWs);

  List<String> days = [
    'Mercoledì 27 gennaio',
    'Martedì 26 gennaio',
    'Lunedì 25 gennaio',
    'Venerdì 22 gennaio'
  ];
  List<List<Worktime>> wts = List();
  wts.add([
    Worktime(0, DateTime.parse('2021-01-27 09:01:00'),
        DateTime.parse('2021-01-27 13:05:00'), 1, 1),
    Worktime(0, DateTime.parse('2021-01-27 13:45:00'),
        DateTime.parse('2021-01-27 17:47:00'), 1, 1)
  ]);
  wts.add([
    Worktime(0, DateTime.parse('2021-01-26 08:56:00'),
        DateTime.parse('2021-01-26 13:05:00'), 1, 1),
    Worktime(0, DateTime.parse('2021-01-26 14:25:00'),
        DateTime.parse('2021-01-26 18:43:00'), 1, 1)
  ]);
  wts.add([
    Worktime(0, DateTime.parse('2021-01-25 09:35:00'),
        DateTime.parse('2021-01-25 13:48:00'), 1, 1),
    Worktime(0, DateTime.parse('2021-01-25 14:45:00'),
        DateTime.parse('2021-01-25 19:20:00'), 1, 1)
  ]);
  wts.add([
    Worktime(0, DateTime.parse('2021-01-22 09:01:00'),
        DateTime.parse('2021-01-22 13:15:00'), 1, 1),
    Worktime(0, DateTime.parse('2021-01-22 14:27:00'),
        DateTime.parse('2021-01-22 18:46:00'), 1, 1)
  ]);

  runApp(MaterialApp(
    title: 'App',
    debugShowCheckedModeBanner: false,
    home: SplashScreen(mediator),
    // TODO: stabilire un tema generale
    routes: {
      'login': (BuildContext context) => LoginView(mediator),
      'ospite': (BuildContext context) => OspiteView(mediator),
      'dashboard': (BuildContext context) => DashboardView(mediator, days, wts),
      'gathering-alert': (BuildContext context) => GatheringAlert(mediator),
      'segnalazione': (BuildContext context) => SegnalazioneView(mediator),
      'registro-attivita': (BuildContext context) =>
          RegistroAttivitaView(mediator),
      'registra-accesso': (BuildContext context) =>
          RegistraAccessoView(mediator)
    },
  ));
}
