import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';

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
  var doableRegistration = true;

  void registraEntrata() async {
    setState(() {
      doableRegistration = false;
    });
    bool res = await widget.mediator.openWorktime();
    setState(() {
      doableRegistration = true;
    });
    if (res) {
      Navigator.pop(context);
    } else {
      FormUtils.showToast('Impossibile registrare entrata', context, 3, false);
    }
  }

  void registraUscita() async {
    setState(() {
      doableRegistration = false;
    });
    bool res = await widget.mediator.closeWorktime();
    setState(() {
      doableRegistration = true;
    });
    if (res) {
      Navigator.pop(context);
    } else {
      FormUtils.showToast('Impossibile registrare uscita', context, 3);
    }
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
                FormUtils.getButton(
                    textButton, onClickButton, doableRegistration),
              ],
            )));
  }
}
