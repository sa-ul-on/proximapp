import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widget/AnnuncioWidget.dart';
import '../model/Annuncio.dart';
import '../widget/MenuWidget.dart';

class BachecaView extends StatefulWidget {
  final List<Widget> widgets = [];

  BachecaView(List<Annuncio> msgs) {
    for (final msg in msgs) {
      widgets.add(AnnuncioWidget(msg));
      widgets.add(SizedBox(height: 15));
    }
    widgets.removeLast();
  }

  @override
  _BachecaViewState createState() => _BachecaViewState();
}

class _BachecaViewState extends State<BachecaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
            backgroundColor: Color(0xffcccccc),
            title: Text('Bacheca'),
            ),
        body:
        ListView.builder(
            padding: EdgeInsets.all(30),
            itemCount: widget.widgets.length,
            itemBuilder: (context, i) {
              return widget.widgets[i];
            }),
        drawer: Theme(
            data: Theme.of(context).copyWith(
            canvasColor: Color(0xffc9daf8),
            ),
            child: Container(
                child:MenuWidget(), padding: EdgeInsets.only(top:35)
            ),
        ),

        backgroundColor: Color(0xfff5f5f5));
  }
}
