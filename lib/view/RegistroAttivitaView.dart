import 'package:flutter/material.dart';

class RegistroAttivitaView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final title = 'Registro Attività';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.hail),
              title: Text('Giorno X'),
            ),
            ListTile(
              leading: Icon(Icons.today_rounded),
              title: Text('Orario di Accesso: '),
            ),
            ListTile(
              leading: Icon(Icons.night_shelter_rounded),
              title: Text('Orario di Uscita:'),
            ),
          ],

        ),
      ),
    );
  }
}
