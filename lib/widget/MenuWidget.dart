import 'package:flutter/material.dart';

import '../Mediator.dart';

class MenuWidget extends StatefulWidget {
  final Mediator mediator;

  MenuWidget(this.mediator);

  @override
  State<StatefulWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  bool openedWorktime;

  @override
  void initState() {
    super.initState();
    openedWorktime = widget.mediator.isWorktimeOpen();
  }

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
                      title: Text(openedWorktime
                          ? 'Registra uscita'
                          : 'Registra entrata'),
                      onTap: () async {
                        await Navigator.pushNamed(context, 'registra-accesso');
                        setState(() {
                          openedWorktime = widget.mediator.isWorktimeOpen();
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.hail),
                      title: Text('Registro attività'),
                      onTap: () =>
                          Navigator.pushNamed(context, 'registro-attivita'),
                    ),
                    ListTile(
                      leading: Icon(Icons.warning),
                      title: Text('Segnalazione'),
                      onTap: () => Navigator.pushNamed(context, 'gathering-alert'),
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
                      onTap: () {
                        widget.mediator.doLogout();
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, 'login');
                      },
                    )
                  ],
                )
              ],
            )));
  }
}
