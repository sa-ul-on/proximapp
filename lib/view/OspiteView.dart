import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proximapp/util/FormUtils.dart';

class OspiteView extends StatefulWidget {
  @override
  _OspiteViewState createState() => _OspiteViewState();
}

class _OspiteViewState extends State<OspiteView> {
  final TextEditingController oneTimeIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            textTheme: TextTheme(
                headline6: TextStyle(color: Color(0xff444444), fontSize: 20)),
            title: Text('Ospite'),
            backgroundColor: Color(0xfff5f5f5),
            elevation: 0,
            leading: GestureDetector(
                onTap: () {
                  print('Indietro non ancora implementato...');
                },
                child: Icon(Icons.arrow_left, color: Colors.black))),
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
