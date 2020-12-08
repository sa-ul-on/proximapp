import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            padding: EdgeInsets.only(top: 35),
            color: Color(0xffc9daf8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.nfc),
                      title: Text('Registra accesso'),
                      onTap: () =>
                          Navigator.pushNamed(context, 'registra-accesso'),
                    ),
                    ListTile(
                      leading: Icon(Icons.hail),
                      title: Text('Registro Attività'),
                      onTap: () =>
                          Navigator.pushNamed(context, 'registro-attivita'),
                    ),
                    ListTile(
                      leading: Icon(Icons.warning),
                      title: Text('Segnalazione'),
                      onTap: () => Navigator.pushNamed(context, 'segnalazione'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Impostazioni'),
                      onTap: () => Navigator.pop(context),
                    ),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Esci'),
                      onTap: () => Navigator.pop(context),
                    )
                  ],
                )
              ],
            )));
  }
}
