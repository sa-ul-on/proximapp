import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proximapp/widget/AppBarMaker.dart';

class SegnalazioneView extends StatefulWidget {
  SegnalazioneView({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SegnalazioneViewState createState() => _SegnalazioneViewState();
}

class _SegnalazioneViewState extends State<SegnalazioneView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: makeAppBar('Invia Segnalazione'),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).

            children: <Widget>[
              Padding(padding: const EdgeInsets.all(40.0)),
              Text(
                'Contatta l’azienda tramite questo form:',
                style: TextStyle(fontSize: 20),
              ),
              Padding(padding: const EdgeInsets.all(20.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    maxLines: 12,
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      fillColor: Color(0xffa4c2f4),
                      hintText: "Salve avrei una richiesta...",
                    ),
                  ),
                ],
              ),
              Padding(padding: const EdgeInsets.all(10.0)),
              FlatButton(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 30.0),
                color: Color(0xff6d9eeb),
                textColor: Colors.white,
                onPressed: () {},
                child: Text("Invia", style: TextStyle(fontSize: 30)),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xfff5f5f5));
  }
}
