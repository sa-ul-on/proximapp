import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../util/FormUtils.dart';
import '../widget/AppBarMaker.dart';

class OspiteView extends StatefulWidget {
  @override
  _OspiteViewState createState() => _OspiteViewState();
}

class _OspiteViewState extends State<OspiteView> {
  final TextEditingController oneTimeIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: makeAppBar('Ospite'),
        body: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30),
            color: Color(0xfff5f5f5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 70),
                Text(
                  'Registrati alla reception per ricevere le credenziali.',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                Form(
                  child: Column(
                    children: [
                      FormUtils.getInputText(
                          'one time id', oneTimeIdController),
                      SizedBox(height: 25),
                      FormUtils.getButton('Entra', () {
                        print("omafdsgasdkf lasjfdg");
                      }),
                    ],
                  ),
                ),
              ],
            )));
  }
}
