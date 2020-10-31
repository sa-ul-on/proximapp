import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Bacheca'),
            onTap: () => {
              Navigator.pushNamed(context, '/bacheca')
            },
          ),
          ListTile(
            leading: Icon(Icons.nfc),
            title: Text('Registra Accesso'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.warning),
            title: Text('Segnalazione'),
            onTap: () => {
              Navigator.pushNamed(context, '/segnalazione')
              },
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Impostazioni'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Esci'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),

    );
  }
}