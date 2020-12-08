import 'package:flutter/material.dart';

import 'BLEManager.dart';
import 'model/Annuncio.dart';
import 'view/BachecaView.dart';
import 'view/LoginView.dart';
import 'view/OspiteView.dart';
import 'view/RegistraAccessoView.dart';
import 'view/RegistroAttivitaView.dart';
import 'view/SegnalazioneView.dart';
import 'view/SplashScreen.dart';
import 'BLEManager.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  var bleManager = BLEManager();
  List<Annuncio> msgs = [
    Annuncio(
        'In sala riunioni ci sono le pizzette per San Raffaele!',
        DateTime.parse('2020-10-26 09:42:27'),
        'Raffaele Contabile',
        Annuncio.INFO),
    Annuncio('Conte ci ha chiuso statevi a casa fino a lunedì',
        DateTime.parse('2020-04-15 21:23:14'), 'Gaetano Gallo', Annuncio.ALERT),
    Annuncio('Quarantena per il reparto NoSQL',
        DateTime.parse('2020-04-02 20:35:44'), 'Mario Russo', Annuncio.URGENT)
  ];
  runApp(MaterialApp(
    title: 'App',
    home: SplashScreen(),
    // TODO: stabilire un tema generale
    routes: {
      'login': (BuildContext context) => LoginView(),
      'ospite': (BuildContext context) => OspiteView(),
      'bacheca': (BuildContext context) => BachecaView(msgs),
      'segnalazione': (BuildContext context) => SegnalazioneView(),
      'registro-attivita': (BuildContext context) => RegistroAttivitaView(),
      'registra-accesso': (BuildContext context) =>
          RegistraAccessoView(bleManager)
    },
  ));
}
