import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Mediator.dart';
import '../util/FormUtils.dart';
import '../widget/AppBarMaker.dart';

class RegistraAccessoView extends StatefulWidget {
  final Mediator mediator;

  RegistraAccessoView(this.mediator);

  @override
  _RegistraAccessoViewState createState() => _RegistraAccessoViewState();
}

class _RegistraAccessoViewState extends State<RegistraAccessoView> {
  /*void onClickAccept() {
    if (RegistraAccessoView.registrato)
      registraUscita();
    else
      registraEntrata();
    setState(() {
      RegistraAccessoView.registrato = !RegistraAccessoView.registrato;
      print(RegistraAccessoView.registrato);
    });
    Navigator.pushNamed(context, 'bacheca');
  }*/

  void registraEntrata() async {
    widget.mediator.openWorktime();
    Navigator.pop(context);
  }

  void registraUscita() async {
    widget.mediator.closeWorktime();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var textButton;
    var onClickButton;
    if (widget.mediator.isWorktimeOpen()) {
      textButton = 'Registra uscita';
      onClickButton = registraUscita;
    } else {
      textButton = 'Registra entrata';
      onClickButton = registraEntrata;
    }
    return Scaffold(
        appBar: makeAppBar('Registra entrata'),
        backgroundColor: Color(0xfff5f5f5),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Avvicina il dispositivo al sensore NFC per registrare '
                    'l\'accesso.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center),
                Image.asset('assets/images/nfcImage.png',
                    width: 500.0, height: 500.0),
                FormUtils.getButton(textButton, onClickButton),
              ],
            )));
  }
}
