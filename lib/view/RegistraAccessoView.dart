import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proximapp/BLEManager.dart';

import '../util/FormUtils.dart';
import '../widget/AppBarMaker.dart';

class RegistraAccessoView extends StatefulWidget {
  final BLEManager bleManager;
  static bool registrato = false;

  RegistraAccessoView(this.bleManager);

  @override
  _RegistraAccessoViewState createState() {
    return _RegistraAccessoViewState(bleManager);
  }
}

class _RegistraAccessoViewState extends State<RegistraAccessoView> {
  final BLEManager bleManager;

  _RegistraAccessoViewState(this.bleManager);

  void registraAccesso() async {
    await bleManager.init();
    print("INIT DONE");
    await bleManager.beaconBroadcast.start(); // inizio il broadcasting
    print(bleManager.beaconBroadcast.isAdvertising());

    bleManager.lookAround();

    // inizio lo scanning

    bleManager.flutterBlue.startScan();
    print("Scan for devices Started");
  }

  void registraUscita() async {
    await bleManager.beaconBroadcast.stop(); // stop broadcasting
    print("broadcasting stop");
    await bleManager.flutterBlue.stopScan(); //stop scanning
    print("monitoring stopped");

    print(bleManager.beaconBroadcast.isAdvertising());
  }

  @override
  Widget build(BuildContext context) {
    var text =
        RegistraAccessoView.registrato ? 'Registra uscita' : 'Registra entrata';
    var reaction = () {
      if (RegistraAccessoView.registrato)
        registraUscita();
      else
        registraAccesso();
      setState(() {
        RegistraAccessoView.registrato = !RegistraAccessoView.registrato;
        print(RegistraAccessoView.registrato);
      });
      Navigator.pushNamed(context, 'bacheca');
    };
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
                    width: 500.0, height: 500.0),
                FormUtils.getButton(text, reaction),
              ],
            )));
  }
}
