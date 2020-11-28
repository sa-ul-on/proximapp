import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/Annuncio.dart';
import '../widget/AnnuncioWidget.dart';
import '../widget/AppBarMaker.dart';
import '../widget/MenuWidget.dart';

class BachecaView extends StatefulWidget {
  final List<Widget> widgets = [];

  BachecaView(List<Annuncio> msgs) {
    for (final msg in msgs) {
      widgets.add(AnnuncioWidget(msg));
      widgets.add(SizedBox(height: 15));
    }
    if (msgs.length > 0) widgets.removeLast();
  }

  @override
  _BachecaViewState createState() => _BachecaViewState();
}

class _BachecaViewState extends State<BachecaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar('Bacheca'),
      drawer: MenuWidget(),
      backgroundColor: Color(0xfff5f5f5),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: widget.widgets.length == 0
            ? createLostView()
            : ListView.builder(
                itemCount: widget.widgets.length,
                itemBuilder: (context, i) {
                  return widget.widgets[i];
                }),
      ),
    );
  }

  Widget createLostView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('La Bacheca è vuota!',
            style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
        Image.asset('assets/images/emptyImage.jpg', width: 500.0, height: 500.0)
      ],
    );
  }
}
