import 'package:flutter/material.dart';

import '../widget/AppBarMaker.dart';

class RegistraAccessoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: makeAppBar('Registra Accesso'),
        backgroundColor: Color(0xfff5f5f5),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Avvicina il dispositivo al sensore NFC per registrare l\'accesso.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center),
                Image.asset('assets/images/nfcImage.png',
                    width: 500.0, height: 500.0)
              ],
            )));
  }
}