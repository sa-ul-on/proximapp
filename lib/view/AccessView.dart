import 'package:flutter/material.dart';

class AccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Registra Accesso"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Avvicina il dispositivo al sensore NFC per registrare l'accesso.",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset('assets/images/nfcImage.png',
              width: 500.0, height: 500.0),
        ],
      ),
    ));
  }
}
