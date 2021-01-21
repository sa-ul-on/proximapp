import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proximapp/util/FormUtils.dart';

import '../widget/AppBarMaker.dart';

class SegnalazioneView extends StatefulWidget {
  dynamic mediator;

  SegnalazioneView(this.mediator);

  @override
  _SegnalazioneViewState createState() => _SegnalazioneViewState();
}

class _SegnalazioneViewState extends State<SegnalazioneView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: makeAppBar('Invia segnalazione'),
        backgroundColor: Color(0xfff5f5f5),
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text('Contatta l\'azienda tramite questo form:',
                  style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
              SizedBox(height: 20),
              Column(
                children: [
                  TextField(
                    maxLines: 12,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: Color(0xffa4c2f4),
                      hintText: 'Salve avrei una richiesta...',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              FormUtils.getButton('Invia', () {
                print('Invio segnalazione');
              })
            ],
          ),
        ));
  }
}
