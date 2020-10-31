import 'package:flutter/material.dart';

import 'model/Annuncio.dart';
import 'view/BachecaView.dart';
import 'view/LoginView.dart';
import 'view/OspiteView.dart';
import 'view/SegnalazioneView.dart';
import 'view/AccessView.dart';

void main() {
  List<Annuncio> msgs = [];
  /*
  var msgs = [
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

   */

  runApp(new MaterialApp(
    title: 'App',
    home: AccessView(),
    // TODO: stabilire un tema generale
    routes: <String, WidgetBuilder>{
      '/bacheca': (BuildContext context) => BachecaView(msgs),
      '/segnalazione': (BuildContext context) => new SegnalazioneView(),
      '/ospite': (BuildContext context) => new OspiteView(),
      // '/login': (BuildContext context) => Login(),
    },
  ));
}
