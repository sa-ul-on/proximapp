import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proximapp/BLEManager.dart';

import '../util/FormUtils.dart';
import '../widget/AppBarMaker.dart';

class RegistraAccessoView extends StatefulWidget {
  final BLEManager bleManager;
  bool registrato = false;

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
    await bleManager.startMonitoring();
    var x = bleManager.lookAround();
    print(x);
  }

  void registraUscita() async {
    await bleManager.stopMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    var text = widget.registrato ? 'Registra uscita' : 'Registra entrata';
    var reaction = () {
      if (widget.registrato)
        registraUscita();
      else
        registraAccesso();
      setState(() {
        widget.registrato = !widget.registrato;
        print(widget.registrato);
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
