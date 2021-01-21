import 'package:flutter/material.dart';

import 'Mediator.dart';
import 'impl/RestUserWs.dart';
import 'impl/RestWorktimeWs.dart';
import 'view/BachecaView.dart';
import 'view/LoginView.dart';
import 'view/OspiteView.dart';
import 'view/RegistraAccessoView.dart';
import 'view/RegistroAttivitaView.dart';
import 'view/SegnalazioneView.dart';
import 'view/SplashScreen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  final Mediator mediator = Mediator();
  var restUserWs = RestUserWs();
  mediator.setUserWs(restUserWs);
  var restWorktimeWs = RestWorktimeWs();
  mediator.setWorktimeWs(restWorktimeWs);

  runApp(MaterialApp(
    title: 'App',
    home: SplashScreen(mediator),
    // TODO: stabilire un tema generale
    routes: {
      'login': (BuildContext context) => LoginView(mediator),
      'ospite': (BuildContext context) => OspiteView(mediator),
      'bacheca': (BuildContext context) => BachecaView(mediator),
      'segnalazione': (BuildContext context) => SegnalazioneView(mediator),
      'registro-attivita': (BuildContext context) =>
          RegistroAttivitaView(mediator),
      'registra-accesso': (BuildContext context) =>
          RegistraAccessoView(mediator)
    },
  ));
}
